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
    @Environment(\.dismiss) private var dismiss
    var mode: LocationPickerMode = .city
    
    private var titleText: String {
        switch mode {
        case .city:
            return "Выберите город"
        case .station(let city):
            return city.name
        }
    }
    
    private var filteredCities: [City] {
        guard case .city = mode else { return [] }
        return viewModel.cities.filter {
            searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private var filteredStations: [Station] {
        guard case .station(let city) = mode else { return [] }
        return city.stations.filter {
            searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        Group {
            switch mode {
            case .city:
                List(filteredCities, id: \.self) { city in
                    NavigationLink(
                        destination: LocationPickerView(
                            viewModel: $viewModel,
                            isOrigin: isOrigin,
                            path: $path,
                            mode: .station(city)
                        )
                    ) {
                        Text(city.name)
                            .font(.regular17)
                    }
                    .listRowSeparator(.hidden, edges: .all)
                }
            case .station:
                List(filteredStations, id: \.self) { station in
                    Button {
                        if isOrigin {
                            viewModel.selectedOrigin = station
                            print("Selected origin: \(station.name)")
                        } else {
                            viewModel.selectedDestination = station
                            print("Selected destination: \(station.name)")
                        }
                        print("OLD PATH: \(path)")
                        path.removeAll()
                        print("NEW PATH: \(path)")
                    } label: {
                        HStack {
                            Text(station.name)
                                .font(.regular17)
                            Spacer()
                            Image(systemName: .chevronRight)
                                .foregroundColor(.primary)
                        }
                        .contentShape(Rectangle())
                    }
                    .listRowSeparator(.hidden, edges: .all)
                }
            }
        }
        .foregroundStyle(.primary, .primary)
        .listStyle(.plain)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Введите запрос")
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

//#Preview {
//    LocationPickerView(viewModel: ViewModel())
//}
