//
//  TripSelectorView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 29.05.2025.
//

import SwiftUI

enum LocationRoute: Hashable {
    case origin
    case destination
    case stationSelection(City, Bool)
}

struct TripSelectorView: View {
    @State private var viewModel: ViewModel = ViewModel()
    @State private var path: [LocationRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ZStack {
                    Color.blue
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            LocationSelectionButton(
                                title: viewModel.originName,
                                isSelected: viewModel.isOriginSelected
                            ) {
                                path.append(.origin)
                            }

                            Spacer()

                            LocationSelectionButton(
                                title: viewModel.destinationName,
                                isSelected: viewModel.isDestinationSelected
                            ) {
                                path.append(.destination)
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

                if viewModel.isOriginSelected && viewModel.isDestinationSelected
                {
                    Button {
                        // Action to start the trip
                    } label: {
                        Text("Найти")
                            .font(.bold17)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 150, maxHeight: 60)
                            .background(Color.blue)
                            .clipShape(.rect(cornerRadius: 16))
                    }
                }

                Spacer()
            }
            .navigationDestination(for: LocationRoute.self) { route in
                switch route {
                case .origin:
                    LocationPickerView(
                        viewModel: $viewModel,
                        isOrigin: true,
                        path: $path
                    )
                case .destination:
                    LocationPickerView(
                        viewModel: $viewModel,
                        isOrigin: false,
                        path: $path
                    )
                case .stationSelection(let city, let isOrigin):
                    LocationPickerView(
                        viewModel: $viewModel,
                        isOrigin: isOrigin,
                        path: $path,
                        mode: .station(city)
                    )
                }
            }
        }
    }
}

#Preview {
    TripSelectorView()
}
