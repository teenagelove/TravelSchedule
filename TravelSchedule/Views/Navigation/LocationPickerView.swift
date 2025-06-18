//
//  LocationPickerView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import SwiftUI

enum LocationPickerMode {
    case city
    case station(City)
}

struct LocationPickerView: View {
    @Binding var viewModel: ViewModel
    @State var isOrigin: Bool = true
    @Binding var path: [LocationRoute]
    @State private var searchText = ""
    @State private var isSearchPresented = false

    var mode: LocationPickerMode = .city

    private var titleText: String {
        switch mode {
        case .city:
            return "Выберите город"
        case .station(let city):
            return city.name
        }
    }

    private var stubText: String {
        switch mode {
        case .city:
            return "Город не найден"
        case .station:
            return "Станция не найдена"
        }
    }

    private var filteredCities: [City] {
        guard case .city = mode else { return [] }
        return viewModel.cities.filter {
            searchText.isEmpty
                || $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var filteredStations: [Station] {
        guard case .station(let city) = mode else { return [] }
        return city.stations.filter {
            searchText.isEmpty
                || $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var isListEmpty: Bool {
        switch mode {
        case .city:
            return filteredCities.isEmpty
        case .station:
            return filteredStations.isEmpty
        }
    }

    var body: some View {
        Group {
            switch mode {
            case .city:
                LocationListView(
                    items: filteredCities,
                    itemTitle: { $0.name },
                    onItemTap: { city in
                        path.append(.stationSelection(city, isOrigin))
                    }
                )
            case .station:
                LocationListView(
                    items: filteredStations,
                    itemTitle: { $0.name },
                    onItemTap: { station in
                        if isOrigin {
                            viewModel.selectedOrigin = station
                        } else {
                            viewModel.selectedDestination = station
                        }
                        path.removeAll()
                    }
                )
            }
        }
        .listStyle(.plain)
        .searchable(
            text: $searchText,
            isPresented: $isSearchPresented,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Введите запрос"
        )
        .onChange(of: path) { _, _ in
            isSearchPresented = false
        }
        .overlay {
            if isListEmpty && !searchText.isEmpty {
                VStack {
                    Spacer()
                    Text(stubText)
                        .font(.bold24)
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
        }
        .navigationTitle(titleText)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = ViewModel()
    LocationPickerView(
        viewModel: $viewModel,
        isOrigin: true,
        path: .constant([]),
        mode: .city
    )
}
