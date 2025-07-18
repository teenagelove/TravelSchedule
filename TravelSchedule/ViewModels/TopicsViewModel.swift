//
//  TopicsViewModel.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import Combine
import SwiftUI

@MainActor
@Observable
final class TopicsViewModel {
    var topics: [Topic] = Topic.allTopics
    var currentProgress: CGFloat = 0
    var currentTopic: Topic?
    var shouldDismiss = false
    
    var currentStoryIndex: Int = 0
    
    var timerConfiguration: TimerConfiguration? {
        currentTopic.map { TimerConfiguration(storiesCount: $0.stories.count) }
    }
    
    private var timer: Timer.TimerPublisher?
    private var cancellable: Cancellable?
    
    func startTimer() {
        guard let config = timerConfiguration else { return }
        timer = Timer.publish(every: config.timerTickInternal, on: .main, in: .common)
        cancellable = timer?.sink { [weak self] _ in self?.tick() }
        _ = timer?.connect()
    }
    
    func stopTimer() {
        cancellable?.cancel()
        cancellable = nil
        timer = nil
        currentProgress = 0
    }
    
    func startViewingTopic(_ topic: Topic) {
        shouldDismiss = false
        currentTopic = topic
        currentStoryIndex = 0
        currentProgress = 0
    }
    
    func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard
            oldIndex != newIndex,
            let config = timerConfiguration,
            oldIndex != config.storiesCount
        else { return }
        
        currentProgress = config.progress(for: newIndex)
        
        if newIndex > oldIndex {
            if newIndex == config.storiesCount - 1 {
                markCurrentTopicAsViewed()
            }
            
            if newIndex >= config.storiesCount {
                isAtLastStoryInLastTopic ? finishLastTopic() : toNextTopic()
            }
        }
    }
    
    func didChangeCurrentProgress(newProgress: CGFloat) {
        guard
            let config = timerConfiguration,
            config.index(for: newProgress) != currentStoryIndex
        else { return }
        
        currentStoryIndex = config.index(for: newProgress)
    }
}

// MARK: - Private Methods
private extension TopicsViewModel {
    var isAtLastStoryInLastTopic: Bool {
        guard
            let topic = currentTopic,
            let index = topics.firstIndex(where: { $0.id == topic.id })
        else { return false }
        
        return currentStoryIndex >= topic.stories.count && index >= (topics.count - 1)
    }
    
    func getNextTopic() -> Topic? {
        guard
            let topic = currentTopic,
            let index = topics.firstIndex(where: { $0.id == topic.id }),
            topics.indices.contains(index + 1)
        else { return nil }
        
        return topics[index + 1]
    }
    
    func tick() {
        guard let config = timerConfiguration else { return }
        
        currentProgress = config.nextProgress(progress: currentProgress)
        
        if currentProgress >= 1.0 {
            isAtLastStoryInLastTopic ? finishLastTopic() : toNextTopic()
        }
    }
    
    func toNextTopic() {
        stopTimer()
        
        if let next = getNextTopic() {
            startViewingTopic(next)
            startTimer()
        } else {
            shouldDismiss = true
        }
    }
    
    func finishLastTopic() {
        markCurrentTopicAsViewed()
        stopTimer()
        shouldDismiss = true
    }
    
    func markCurrentTopicAsViewed() {
        guard let current = currentTopic else { return }
        
        topics = topics.map {
            $0.id == current.id ? $0.markAsViewed() : $0
        }
    }
}
