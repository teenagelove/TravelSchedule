//
//  RouteViewModel.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//

import SwiftUI

@Observable
final class RouteViewModel {
    private let allRoutes: [Route] = RouteMock.routes
    
    var routes: [Route] = []
    
    var selectedTimeSlots: Set<TimeSlot> = []
    var showTransfers: Bool = true
    var isFilterApplied: Bool = false
    
    init() {
        routes = allRoutes
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
    func filterRoutes(_ routes: [Route]) -> [Route] {
        return routes.filter { route in
            let timeMatches =
            selectedTimeSlots.isEmpty
            || selectedTimeSlots.contains { timeSlot in
                timeSlot.contains(time: route.startingTime)
            }
            
            let transferMatches: Bool
            
            if showTransfers {
                transferMatches = true
            } else {
                transferMatches = route.transfer == nil
            }
            
            return timeMatches && transferMatches
        }
    }
}
