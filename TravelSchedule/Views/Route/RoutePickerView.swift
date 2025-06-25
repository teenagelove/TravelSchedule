//
//  RoutePickerView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//

import SwiftUI

struct RoutePickerView: View {
    @State var viewModel = RouteViewModel()
    var originName: String
    var destinationName: String

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
            .overlay {
                if viewModel.routes.isEmpty {
                    Text("Вариантов нет")
                        .font(.bold24)
                        .foregroundStyle(.primary)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
        }
    }
}

#Preview {
    RoutePickerView(
        originName: "Москва (Ярославский вокзал)",
        destinationName: "Санкт-Петербург (Балтийский вокзал)"
    )
}
