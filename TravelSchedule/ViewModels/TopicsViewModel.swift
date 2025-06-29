//
//  TopicsViewModel.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import Combine
import SwiftUI

@Observable
final class TopicsViewModel {
    var topics: [Topic] = Topic.allTopics
    var currentProgress: CGFloat = 0
    var currentTopic: Topic?
    var shouldDismiss = false
    
    var currentStoryIndex: Int = 0 {
        didSet {
            handleStoryIndexChange(oldValue: oldValue, newValue: currentStoryIndex)
        }
    }
    
    var timerConfiguration: TimerConfiguration? {
        guard let currentTopic = currentTopic else { return nil }
        return TimerConfiguration(storiesCount: currentTopic.stories.count)
    }
    
    private var timer: Timer.TimerPublisher?
    private var cancellable: Cancellable?
    private var skipProgressUpdate = false
    
    func startTimer() {
        guard let config = timerConfiguration else { return }
        timer = Timer.publish(every: config.timerTickInternal, on: .main, in: .common)
        cancellable = timer?.sink { [weak self] _ in
            self?.tick()
        }
        _ = timer?.connect()
    }
    
    func stopTimer() {
        cancellable?.cancel()
        cancellable = nil
        timer = nil
    }
    
    func startViewingTopic(_ topic: Topic) {
        shouldDismiss = false
        skipProgressUpdate = false
        currentStoryIndex = 0
        currentProgress = 0
        currentTopic = topic
    }
    
    func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard !skipProgressUpdate else { return }
        guard oldIndex != newIndex else { return }
        guard let timerConfig = timerConfiguration else { return }
        
        let progress = timerConfig.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        
        
        withAnimation {
            currentProgress = progress
        }
    }
    
    func didChangeCurrentProgress(newProgress: CGFloat) {
        guard !skipProgressUpdate else { return }
        guard let timerConfig = timerConfiguration else { return }
        let index = timerConfig.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        
        withAnimation {
            currentStoryIndex = index
        }
    }
}

private extension TopicsViewModel {
    var isAtLastStoryInLastTopic: Bool {
        guard let currentTopic = currentTopic else { return false }
        guard let currentTopicIndex = topics.firstIndex(where: { $0.id == currentTopic.id }) else { return false }
        
        let atLastStory = currentStoryIndex >= currentTopic.stories.count
        let isLastTopic = currentTopicIndex >= (topics.count - 1)
        
        return atLastStory && isLastTopic
    }
    
    func getNextTopic() -> Topic? {
        guard let currentTopic = currentTopic else { return nil }
        guard let currentIndex = topics.firstIndex(where: { $0.id == currentTopic.id }) else { return nil }
        
        let nextIndex = currentIndex + 1
        return topics.indices.contains(nextIndex) ? topics[nextIndex] : nil
    }
    
    func tick() {
        guard let config = timerConfiguration else { return }
        
        let newProgress = config.nextProgress(progress: currentProgress)
        
        withAnimation {
            currentProgress = newProgress
        }
        
        if newProgress >= 1.0 {
            if isAtLastStoryInLastTopic {
                markCurrentTopicAsViewed()
                stopTimer()
                shouldDismiss = true
            } else {
                withAnimation {
                    toNextTopic()
                }
            }
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
    
    func handleStoryIndexChange(oldValue: Int, newValue: Int) {
        guard let config = timerConfiguration else { return }
        
        if newValue > oldValue {
            if newValue == config.storiesCount - 1 {
                markCurrentTopicAsViewed()
            }
            
            if newValue >= config.storiesCount {
                if isAtLastStoryInLastTopic {
                    stopTimer()
                    shouldDismiss = true
                    skipProgressUpdate = true
                } else {
                    toNextTopic()
                }
            }
        }
    }
    
    func markCurrentTopicAsViewed() {
        guard let currentTopic = currentTopic else { return }
        
        topics = topics.map { topic in
            if topic.id == currentTopic.id {
                return topic.markAsViewed()
            } else {
                return topic
            }
        }
    }
}
