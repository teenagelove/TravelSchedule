//
//  StoriesRootView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import SwiftUI

struct StoriesRootView: View {
    let viewModel: TopicsViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesView(viewModel: viewModel)
            CloseButton()
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
    }
}

#Preview {
    let vm = TopicsViewModel()
    vm.startViewingTopic(Topic.topic1)
    
    return StoriesRootView(viewModel: vm)
}
