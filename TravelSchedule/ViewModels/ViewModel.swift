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
    var selectedStation: Station? = nil
    
    init() {
        // Mock data
        cities = CityMock.cities
    }
}
