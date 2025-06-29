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
    @State private var internalIndex: Int = .zero

    var body: some View {
        TabView(selection: $internalIndex) {
            ForEach(0..<stories.count + 1, id: \.self) { index in
                if index < stories.count {
                    StoryView(story: stories[index])
                        .onTapGesture {
                            currentStoryIndex += 1
                        }
                } else {
                    Color.black
                        .ignoresSafeArea()
                }
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .onAppear {
            withAnimation {
                internalIndex = currentStoryIndex
            }
        }
        .onChange(of: internalIndex) { _, newValue in
            withAnimation {
                currentStoryIndex = newValue
            }
        }
        .onChange(of: currentStoryIndex) { oldValue, newValue in
            withAnimation {
                internalIndex = newValue
            }
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
