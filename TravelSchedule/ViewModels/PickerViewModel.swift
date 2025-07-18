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
    
    // MARK: - Properties
    var cities: [City] = []
    
    var selectedOrigin: Station? = nil
    var selectedDestination: Station? = nil
    
    var loadingStatus: LoadingStatus = .none
    
    var isOriginSelected: Bool { selectedOrigin != nil }
    
    var isDestinationSelected: Bool { selectedDestination != nil }
    
    var originName: String {
        stationDisplayName(for: selectedOrigin, defaultName: "Откуда")
    }
    
    var destinationName: String {
        stationDisplayName(for: selectedDestination, defaultName: "Куда")
    }
    
    // MARK: - Private Properties
    private let networkClient = NetworkClient()
    
    // MARK: - Public Methods
    func loadStations() async {
        guard cities.isEmpty else { return }
        
        loadingStatus = .loading
        defer { if loadingStatus == .loading { loadingStatus = .none } }
        
        do {
            let stations = try await networkClient.getAllStations()
            cities = filterCities(from: stations)
        } catch NetworkError.noInternet {
            loadingStatus = .networkError
        } catch {
            loadingStatus = .serverError
        }
    }
    
    func switchOriginDestination() {
        (selectedOrigin, selectedDestination) = (selectedDestination, selectedOrigin)
    }
}

// MARK: - Private Methods
private extension PickerViewModel {
    func stationDisplayName(for station: Station?, defaultName: String) -> String {
        guard let station = station,
              let city = cities.first(where: { $0.stations.contains(station) })
        else { return defaultName }
        return "\(city.name) (\(station.name))"
    }
}

// MARK: - Private Nonisolated Methods
nonisolated private extension PickerViewModel {
    func filterCities(from stationsList: AllStations) -> [City] {
        guard let country = stationsList.countries?.first(where: { $0.codes?.yandex_code == Constants.ruCode }) else {
            return []
        }
        
        let settlements = country.regions?
            .flatMap { $0.settlements ?? [] } ?? []
        
        let cities = settlements
            .compactMap(createCity(from:))
            .sorted { $0.name < $1.name }
        
        return cities
    }
    
    func createCity(from settlement: SettlementInfo) -> City? {
        guard let cityName = settlement.title, !cityName.isEmpty else { return nil }
        
        let stations = settlement.stations?
            .compactMap { transformStation(from: $0, cityName: cityName) }
            .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending } ?? []
        
        guard !stations.isEmpty else { return nil }
        
        return City(name: cityName, stations: stations)
    }
    
    func transformStation(from rawStation: StationInfo, cityName: String) -> Station? {
        guard
            rawStation.transport_type == "train",
            let title = rawStation.title,
            let code = rawStation.codes?.yandex_code
        else { return nil }
        
        let cleanName = removeCityName(from: title, cityName: cityName)
        let finalName = removeBrackets(from: cleanName)
        return Station(name: finalName, code: code)
    }
    
    func removeCityName(from stationName: String, cityName: String) -> String {
        let trimmedName = stationName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedCity = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.hasPrefix(trimmedCity) {
            let remainder = trimmedName.dropFirst(trimmedCity.count)
            
            if let firstChar = remainder.first, firstChar == "-" || firstChar.isNumber {
                return trimmedName
            }
            
            if remainder.first == " " {
                return String(remainder).trimmingCharacters(in: .whitespaces)
            }
        }
        
        return trimmedName
    }
    
    func removeBrackets(from stationName: String) -> String {
        return stationName.replacingOccurrences(of: "[()\\[\\]]", with: "", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
    }
}
