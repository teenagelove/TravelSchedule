//
//  TimerConfiguration.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import Foundation

struct TimerConfiguration {
    let storiesCount: Int
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat

    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.05
    ) {
        self.storiesCount = storiesCount
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}

extension TimerConfiguration {
    func progress(for storyIndex: Int) -> CGFloat {
        return min(CGFloat(storyIndex) / CGFloat(storiesCount), 1)
    }

    func index(for progress: CGFloat) -> Int {
        return min(Int(progress * CGFloat(storiesCount)), storiesCount - 1)
    }

    func nextProgress(progress: CGFloat) -> CGFloat {
        return min(progress + progressPerTick, 1)
    }
    
    func isLastStory(for storyIndex: Int) -> Bool {
        return storyIndex == storiesCount - 1
    }
}
