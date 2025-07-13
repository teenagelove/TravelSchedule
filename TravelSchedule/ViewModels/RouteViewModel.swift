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
    var isServerError = false
    var isLoading = false
    
    private let allRoutes: [Route] = []
    private let networkClient = NetworkClient()
    
    func loadRoutes(from: String, to: String) async {
        guard routes.isEmpty else { return }
        
        isLoading = true
        isServerError = false
        
        defer { isLoading = false }
        
        do {
            async let fetchedRoutes = networkClient.getScheduleBetweenStations(
                from: from,
                to: to,
                date: Date().toStringFormat()
            )
            
            try await getRoutes(searchedResult: fetchedRoutes)
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
        var newRoutes: [Route] = []

        for segment in searchedResult.segments ?? [] {
            guard
                let date = segment.start_date,
                let startingTime = segment.departure,
                let arrival = segment.arrival,
                let duration = segment.duration,
                let transfer = segment.has_transfers,
                let carrierCode = segment.thread?.carrier?.code,
                let carrierFullName = segment.thread?.carrier?.title
            else { continue }
            
            let carrier = Carrier(
                name: carrierFullName,
                fullName: carrierFullName,
                imageName: segment.thread?.carrier?.logo ?? "",
                email: segment.thread?.carrier?.email,
                phone: segment.thread?.carrier?.phone
            )

            let route = Route(
                code: carrierCode,
                carrier: carrier,
                date: date,
                startingTime: startingTime,
                arrivalTime: arrival,
                travelTime: duration,
                transfer: transfer
            )

            newRoutes.append(route)

            print("""
            ✅ Найден маршрут:
            - Перевозчик: \(carrier.fullName) (\(carrier.name))
            - Код перевозчика: \(route.code)
            - Дата: \(date)
            - Время отправления: \(startingTime)
            - Время прибытия: \(arrival)
            - Продолжительность: \(duration)
            - Логотип: \(carrier.imageName)
            - Логотип SVG: \(segment.thread?.carrier?.logo_svg ?? "Пустое")
            - Пересадки: \(transfer ? "Да" : "Нет")
            - Email перевозчика: \(carrier.email ?? "Не указано")
            - Телефон перевозчика: \(carrier.phone ?? "Не указано")
            """)
        }

        print("🔄 Всего маршрутов найдено: \(newRoutes.count)")
        routes = newRoutes
    }
    
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
