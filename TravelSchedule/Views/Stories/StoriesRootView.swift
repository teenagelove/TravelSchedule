//
//  StoriesRootView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import SwiftUI

struct StoriesRootView: View {
    let stories: [Story]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesView(stories: stories)
            CloseButton()
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
    }
}

#Preview {
    let stories = Topic.topic1.stories
    
    StoriesRootView(stories: stories)
}
