//
//  RoutePickerView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//

import SwiftUI

struct RoutePickerView: View {
    @State var viewModel = RouteViewModel()
    let originName: String
    let destinationName: String
    let fromCode: String
    let toCode: String

    var body: some View {
        NavigationStack {
            VStack {
                Text("\(originName) → \(destinationName)")
                    .font(.bold24)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.routes) { route in
                                NavigationLink(
                                    destination: {
                                        CarrierView(carrier: route.carrier)
                                    },
                                    label: {
                                        RouteView(route: route)
                                    }
                                )
                            }
                        }
                        .padding(.bottom, 80)
                    }
                    .scrollIndicators(.hidden)

                    if !viewModel.isLoading && !viewModel.isServerError
                        && !viewModel.isNetworkError
                    {
                        NavigationLink(
                            destination: {
                                FilterView(viewModel: $viewModel)
                            },
                            label: {
                                BlueLabel(
                                    text: "Уточнить время",
                                    isFilterApplied: viewModel.isFilterApplied
                                )
                            }
                        )
                    }
                }
            }
            .overlay {
                overlay
            }
            .padding(.horizontal)
            .padding(.top)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
        }
        .task {
            await viewModel.loadRoutes(from: fromCode, to: toCode)
        }
    }

    @ViewBuilder
    private var overlay: some View {
        OverlayStatusView(
            isLoading: viewModel.isLoading,
            isNetworkError: viewModel.isNetworkError,
            isServerError: viewModel.isServerError
        ) {
            if viewModel.routes.isEmpty {
                Text("Вариантов нет")
                    .font(.bold24)
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    RoutePickerView(
        originName: "Москва (Ярославский вокзал)",
        destinationName: "Санкт-Петербург (Балтийский вокзал)",
        fromCode: "s2000007",
        toCode: "s9602494"
    )
}
