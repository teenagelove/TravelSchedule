//
//  StoriesTabView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import SwiftUI

struct StoriesTabView: View {
    let stories: [Story]
    @Binding var currentStoryIndex: Int
    
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(stories.indices, id: \.self) { index in
                StoryView(story: stories[index])
                    .onTapGesture {
                        didTapStory()
                    }
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

private extension StoriesTabView {
    func didTapStory() {
        withAnimation {
            currentStoryIndex += 1
        }
    }
}

#Preview {
    @Previewable @State var currentStoryIndex = 0
    StoriesTabView(
        stories: Topic.topic1.stories,
        currentStoryIndex: $currentStoryIndex
    )
}
