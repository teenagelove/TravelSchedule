//
//  StoriesProgressBar.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import Combine
import SwiftUI

struct StoriesProgressBar: View {
    @Bindable var viewModel: TopicsViewModel
    
    var body: some View {
        ProgressBar(
            numberOfSections: viewModel.timerConfiguration?.storiesCount ?? 1,
            progress: viewModel.currentProgress
        )
            .padding(.init(top: 7, leading: 12, bottom: 12, trailing: 12))
            .onAppear {
                viewModel.startTimer()
            }
            .onDisappear {
                viewModel.stopTimer()
            }
    }
}

#Preview {
    let vm = TopicsViewModel()
    StoriesProgressBar(viewModel: vm)
}
