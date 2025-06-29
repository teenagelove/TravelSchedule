//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import SwiftUI

struct StoriesView: View {
    @Bindable var viewModel: TopicsViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(
                stories: viewModel.currentTopic?.stories ?? [],
                currentStoryIndex: $viewModel.currentStoryIndex
            )
            .id(viewModel.currentTopic?.id)
            .onChange(of: viewModel.shouldDismiss) { oldValue, newValue in
                if newValue {
                    dismiss()
                }
            }
            .onChange(of: viewModel.currentStoryIndex) { oldValue, newValue in
                withAnimation {
                    viewModel.didChangeCurrentIndex(
                        oldIndex: oldValue,
                        newIndex: newValue
                    )
                }
            }

            StoriesProgressBar(viewModel: viewModel)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
                .onChange(of: viewModel.currentProgress) { _, newValue in
                    withAnimation {
                        viewModel.didChangeCurrentProgress(
                            newProgress: newValue
                        )
                    }
                }
        }
    }
}

#Preview {
    let vm = TopicsViewModel()
    vm.startViewingTopic(Topic.topic1)

    return StoriesView(viewModel: vm)
}
