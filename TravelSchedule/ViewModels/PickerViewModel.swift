//
//  PickerViewModel.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import SwiftUI

@MainActor
@Observable
final class PickerViewModel {
    var cities: [City] = []
    var selectedOrigin: Station? = nil
    var selectedDestination: Station? = nil
    
    var stations: [Station] = []
    var isServerError = false
    var isLoading = false
    
    private let networkClient = NetworkClient()
    
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
    
    func loadStations() async {
        guard stations.isEmpty else { return }
        
        isLoading = true
        isServerError = false
        
        defer { isLoading = false }
        
        do {
            async let station = networkClient.getAllStations()
            try await filterStationsByCity(for: station)
        } catch {
            isServerError = true
        }
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

private extension PickerViewModel {
    func filterStationsByCity(for stationsList: AllStations) async throws {
        guard let country = stationsList.countries?.first(where: { $0.codes?.yandex_code == Constants.ruCode }) else {
            return
        }
        
        let settlements = country.regions?
            .compactMap(\.settlements)
            .flatMap { $0 } ?? []
        
        let cities = settlements
            .compactMap(createCity(from:))
            .sorted(by: { $0.name < $1.name })
        
        self.cities = cities
    }
    
    func createCity(from settlement: SettlementInfo) -> City? {
        guard let cityName = settlement.title, !cityName.isEmpty else {
            return nil
        }
        
        let stations = settlement.stations?.compactMap(transformStation) ?? []
        
        guard !stations.isEmpty else {
            return nil
        }
        
        return City(name: cityName, stations: stations)
    }
    
    func transformStation(from rawStation: StationInfo) -> Station? {
        guard
            rawStation.transport_type == "train",
            let title = rawStation.title,
            let code = rawStation.codes?.yandex_code
        else {
            return nil
        }
        
        let cleanName = removeCityName(from: title)
        let finalName = removeBrackets(from: cleanName)
        return Station(name: finalName, code: code)
    }
    
    func removeCityName(from stationName: String) -> String {
        let words = stationName.split(separator: " ")
        return words.count > 1 ? words.dropFirst().joined(separator: " ") : stationName
    }
    
    func removeBrackets(from stationName: String) -> String {
        return stationName.replacingOccurrences(of: "[()\\[\\]]", with: "", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
    }
}
