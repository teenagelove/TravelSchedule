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
            ForEach(0..<stories.count + 1, id: \.self) { index in
                if index < stories.count {
                    StoryView(story: stories[index])
                        .onTapGesture {
                            didTapStory()
                        }
                } else {
                    Color.black
                        .ignoresSafeArea()
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
