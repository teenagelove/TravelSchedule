//
//  LocationPickerView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import SwiftUI

struct LocationPickerView: View {
    let title: String
    let stubText: String
    let cities: [City]
    let stations: [Station]
    @Binding var path: [LocationRoute]
    @Binding var viewModel: ViewModel
    var isOrigin: Bool = true
    var onClose: (() -> Void)? = nil

    @State private var searchText = ""
    @State private var isSearchPresented = false

    private var filteredCities: [City] {
        cities.filter {
            searchText.isEmpty
                || $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var filteredStations: [Station] {
        stations.filter {
            searchText.isEmpty
                || $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var isListEmpty: Bool {
        !cities.isEmpty ? filteredCities.isEmpty : filteredStations.isEmpty
    }

    var body: some View {
        Group {
            if !cities.isEmpty {
                LocationListView(
                    items: filteredCities,
                    itemTitle: { $0.name },
                    onItemTap: { city in
                        path.append(.station(city))
                        searchText = ""
                    }
                )
            } else {
                LocationListView(
                    items: filteredStations,
                    itemTitle: { $0.name },
                    onItemTap: { station in
                        if isOrigin {
                            viewModel.selectedOrigin = station
                        } else {
                            viewModel.selectedDestination = station
                        }
                        onClose?()
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
                        .font(.title.bold())
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
        }
        .navigationTitle(title)
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
    @Previewable @State var path = [LocationRoute]()
    LocationPickerView(
        title: "Выбор локации",
        stubText: "Город не найден",
        cities: [],
        stations: viewModel.cities[0].stations,
        path: $path,
        viewModel: $viewModel
    )
}
