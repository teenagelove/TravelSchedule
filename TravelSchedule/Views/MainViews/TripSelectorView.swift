//
//  TripSelectorView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 29.05.2025.
//

import SwiftUI

struct TripSelectorView: View {
    @State private var viewModel: PickerViewModel = PickerViewModel()
    @State private var isPresentingOriginPicker = false
    @State private var isPresentingDestinationPicker = false
    @State private var isPresentingRoutePicker = false
    @State private var selectedTopic: Topic? = nil
    
    private let topics = Topic.allTopics

    var body: some View {
        VStack {
            StoriesPreview(topics: topics) { topic in
                selectedTopic = topic
            }
            
            ZStack {
                Color.blue
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        LocationSelectionButton(
                            title: viewModel.originName,
                            isSelected: viewModel.isOriginSelected
                        ) {
                            isPresentingOriginPicker = true
                        }

                        Spacer()

                        LocationSelectionButton(
                            title: viewModel.destinationName,
                            isSelected: viewModel.isDestinationSelected
                        ) {
                            isPresentingDestinationPicker = true
                        }
                    }
                    .padding()
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .leading
                    )
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button {
                        viewModel.switchOriginDestination()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 36, height: 36)
                            Image(systemName: .squarePath)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding()
            }
            .frame(height: 128)
            .padding()

            if viewModel.isOriginSelected && viewModel.isDestinationSelected {
                Button {
                    isPresentingRoutePicker = true
                } label: {
                    Text("Найти")
                        .font(.bold17)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: 150, maxHeight: 60)
                        .background(Color.blue)
                        .clipShape(.rect(cornerRadius: 16))
                }
            }

            Spacer()
        }
        .fullScreenCover(isPresented: $isPresentingOriginPicker) {
            LocationPickerRootView(
                viewModel: $viewModel,
                isOrigin: true,
                onClose: { isPresentingOriginPicker = false }
            )
        }
        .fullScreenCover(isPresented: $isPresentingDestinationPicker) {
            LocationPickerRootView(
                viewModel: $viewModel,
                isOrigin: false,
                onClose: { isPresentingDestinationPicker = false }
            )
        }
        .fullScreenCover(isPresented: $isPresentingRoutePicker) {
            RoutePickerView(
                originName: viewModel.originName,
                destinationName: viewModel.destinationName,
            )
        }
        .fullScreenCover(item: $selectedTopic) { topic in
            StoriesRootView(stories: topic.stories)
        }
    }
}
#Preview {
    TripSelectorView()
}
