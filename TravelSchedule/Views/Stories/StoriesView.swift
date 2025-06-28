//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import SwiftUI

struct StoriesView: View {
    let stories: [Story]
    @State var topic: Topic = Topic.topic1
    
    private var timerConfiguration: TimerConfiguration {
        .init(storiesCount: stories.count)
    }
    @State var currentStoryIndex: Int = 0
    @State var currentProgress: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(
                stories: stories,
                currentStoryIndex: $currentStoryIndex
            )
            .onChange(of: currentStoryIndex) { oldValue, newValue in
                didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
            }
            
            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            .onChange(of: currentProgress) { _, newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
        }
    }
}

private extension StoriesView {
    func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }
    
    func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = timerConfiguration.index(for: newProgress)
        
        if newProgress == 1.0 {
            topic.isViewed = true
        }
        
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}

#Preview {
    let stories = Topic.topic1.stories
    
    StoriesView(stories: stories)
}
