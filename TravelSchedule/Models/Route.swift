//
//  Route.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//

import Foundation

struct Route: Hashable, Identifiable, Sendable {
    let id = UUID()
    let code: Int
    let carrier: Carrier
    let date: String
    let startingTime: String
    let arrivalTime: String
    let travelTime: Int
    let transfer: Bool
}
