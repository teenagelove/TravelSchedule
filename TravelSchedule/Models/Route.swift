//
//  Route.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//

import Foundation

struct Route: Hashable, Identifiable {
    let id = UUID()
    let carrier: Carrier
    let date: String
    let startingTime: String
    let arrivalTime: String
    let travelTime: String
    let transfer: String?
}
