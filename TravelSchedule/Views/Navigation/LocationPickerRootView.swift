//
//  LocationRootView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 18.06.2025.
//

import SwiftUI

enum LocationRoute: Hashable {
    case city
    case station(City)
}

struct LocationPickerRootView: View {
    @Binding var viewModel: ViewModel
    @State var path: [LocationRoute] = []
    var isOrigin: Bool
    var onClose: (() -> Void)? = nil

    var body: some View {
        NavigationStack(path: $path) {
            LocationPickerView(
                title: "Выберите город",
                stubText: "Город не найден",
                cities: viewModel.cities,
                stations: [],
                path: $path,
                viewModel: $viewModel,
                isOrigin: isOrigin
            )
            .navigationDestination(for: LocationRoute.self) { route in
                switch route {
                case .city:
                    EmptyView()
                case .station(let city):
                    LocationPickerView(
                        title: city.name,
                        stubText: "Станция не найдена",
                        cities: [],
                        stations: city.stations,
                        path: $path,
                        viewModel: $viewModel,
                        isOrigin: isOrigin,
                        onClose: onClose
                    )
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = ViewModel()
    LocationPickerRootView(viewModel: $viewModel, isOrigin: true)
}
