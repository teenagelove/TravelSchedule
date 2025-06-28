//
//  TopicsViewModel.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import Combine
import SwiftUI

@Observable
class TopicsViewModel {
    var topics: [Topic] = Topic.allTopics
    var currentStoryIndex: Int = 0
    var currentProgress: CGFloat = 0
    var currentTopic: Topic?
    
    var timerConfiguration: TimerConfiguration? {
        guard let currentTopic = currentTopic else { return nil }
        return TimerConfiguration(storiesCount: currentTopic.stories.count)
    }
    
    private var timer: Timer.TimerPublisher?
    private var cancellable: Cancellable?
    
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
        currentProgress = 0
    }
    
    func startViewingTopic(_ topic: Topic) {
        currentTopic = topic
        currentStoryIndex = 0
        currentProgress = 0
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
    
    func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        guard let timerConfig = timerConfiguration else { return }
        
        if timerConfig.isLastStory(for: currentStoryIndex) {
            markCurrentTopicAsViewed()
        }
        
        let progress = timerConfig.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }
    
    func didChangeCurrentProgress(newProgress: CGFloat) {
        guard let timerConfig = timerConfiguration else { return }
        let index = timerConfig.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}

private extension TopicsViewModel {
    func nextTopic() -> Topic? {
        guard let currentTopic = currentTopic else { return nil }
        guard let currentIndex = topics.firstIndex(where: { $0.id == currentTopic.id }) else { return nil }
        
        let nextIndex = currentIndex + 1
        return topics.indices.contains(nextIndex) ? topics[nextIndex] : nil
    }
    
    func tick() {
        guard let config = timerConfiguration else { return }
        
        let newProgress = config.nextProgress(progress: currentProgress)
        
        withAnimation {
            currentProgress = config.nextProgress(progress: currentProgress)
        }
        
        if newProgress >= 1.0 {
            markCurrentTopicAsViewed()
            stopTimer()

            if let next = nextTopic() {
                startViewingTopic(next)
            }
        }
    }
}
