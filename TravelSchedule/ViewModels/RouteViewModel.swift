//
//  RouteViewModel.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//

import SwiftUI

@MainActor
@Observable
final class RouteViewModel {
    var routes: [Route] = []
    var selectedTimeSlots: Set<TimeSlot> = []
    var showTransfers: Bool = true
    var isFilterApplied: Bool = false
    
    var isLoading = false
    var isNetworkError = false
    var isServerError = false
    
    private var allRoutes: [Route] = []
    private let networkClient = NetworkClient()
    
    func loadRoutes(from: String, to: String) async {
        guard routes.isEmpty else { return }
        
        isLoading = true
        isNetworkError = false
        isServerError = false
        
        defer { isLoading = false }
        
        do {
            let fetchedRoutes = try await networkClient.getScheduleBetweenStations(
                from: from,
                to: to,
                date: Date().toString()
            )
            
            getRoutes(searchedResult: fetchedRoutes)
        } catch NetworkError.noInternet {
            isNetworkError = true
        } catch {
            isServerError = true
        }
    }
    
    // MARK: - Filter Methods
    func applyFilters() {
        routes = filterRoutes(allRoutes)
        isFilterApplied = !selectedTimeSlots.isEmpty || !showTransfers
    }
    
    func toggleTimeSlot(_ timeSlot: TimeSlot) {
        if selectedTimeSlots.contains(timeSlot) {
            selectedTimeSlots.remove(timeSlot)
        } else {
            selectedTimeSlots.insert(timeSlot)
        }
    }
    
    func setShowTransfers(_ show: Bool) {
        showTransfers = show
    }
}

// MARK: - Private Methods
private extension RouteViewModel {
    func getRoutes(searchedResult: SearchedRoutes) {
        let newRoutes = (searchedResult.segments ?? []).compactMap { Route(segment: $0) }
        allRoutes = newRoutes
        routes = filterRoutes(newRoutes)
    }
    
    func filterRoutes(_ routes: [Route]) -> [Route] {
        return routes.filter { route in
            guard let date = route.startingTime.isoDate else { return false }
            
            let timeMatches = selectedTimeSlots.isEmpty || selectedTimeSlots.contains { timeSlot in
                timeSlot.contains(date: date)
            }
            
            let transferMatches = showTransfers || !route.transfer
            
            return timeMatches && transferMatches
        }
    }
}
