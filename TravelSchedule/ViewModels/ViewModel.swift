//
//  ViewModel.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import SwiftUI

@Observable
final class ViewModel {
    var cities: [City] = []
    var selectedOrigin: Station? = nil
    var selectedDestination: Station? = nil
    
    var isOriginSelected: Bool {
        selectedOrigin != nil
    }
    
    var isDestinationSelected: Bool {
        selectedDestination != nil
    }
    
    var originName: String {
        if let selectedOrigin = selectedOrigin,
           let city = cities.first(where: { $0.stations.contains(selectedOrigin) }) {
            return "\(city.name) (\(selectedOrigin.name))"
        }
        return "Откуда"
    }
    
    var destinationName: String {
        if let selectedDestination = selectedDestination,
           let city = cities.first(where: { $0.stations.contains(selectedDestination) }) {
            return "\(city.name) (\(selectedDestination.name))"
        }
        return "Куда"
    }
    
    init() {
        // Mock data
        cities = CityMock.cities
    }
    
    func switchOriginDestination() {
        guard
            let selectedOrigin,
            let selectedDestination
        else { return }
        
        self.selectedOrigin = selectedDestination
        self.selectedDestination = selectedOrigin
    }
}
