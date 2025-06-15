//
//  CityPickerView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import SwiftUI

enum LocationPickerMode {
    case city
    case station(City)
}

struct CityPickerView: View {
    @State private var viewModel = ViewModel()
    @State private var searchText = ""
    
    var filteredCities: [City] {
        if searchText.isEmpty {
            return viewModel.cities
        } else {
            return viewModel.cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        List(filteredCities, id: \.self) { city in
            NavigationLink(destination: Text("Selected city: \(city.name)")
                .navigationTitle(city.name)) {
                    Text(city.name)
                        .font(.regular17)
                }
                .padding(.vertical)
                .listRowSeparator(.hidden, edges: .all)
                .foregroundStyle(.primary, .primary)
        }
        .listStyle(.plain)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Введите запрос")
        .navigationTitle("Выберите город")
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
    CityPickerView()
}
