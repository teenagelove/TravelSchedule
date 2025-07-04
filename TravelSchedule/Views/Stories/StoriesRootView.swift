//
//  StoriesRootView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import SwiftUI

struct StoriesRootView: View {
    @Bindable var viewModel: TopicsViewModel
    @State private var dragOffset: CGSize = .zero
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesView(viewModel: viewModel)
            CloseButton()
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .offset(y: dragOffset.height)
        .opacity(1 - abs(dragOffset.height) / 500.0)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    if dragCondition(value.translation) {
                        dragOffset = CGSize(width: 0, height: value.translation.height)
                    }
                })
                .onEnded({ value in
                    if dragCondition(value.translation) && value.translation.height > 150 {
                        dismiss()
                    } else {
                        withAnimation(.spring()) {
                            dragOffset = .zero
                        }
                    }
                })
        )
    }
}

private extension StoriesRootView {
    func dragCondition(_ translation: CGSize) -> Bool {
        let horizontalAmount = abs(translation.width)
        let verticalAmount = abs(translation.height)
        let isStrictlyVertical = verticalAmount > horizontalAmount * 3
        let isDownward = translation.height > 0
        
        return isDownward && isStrictlyVertical
    }
}

#Preview {
    let vm = TopicsViewModel()
    vm.startViewingTopic(Topic.topic1)
    
    return StoriesRootView(viewModel: vm)
}
