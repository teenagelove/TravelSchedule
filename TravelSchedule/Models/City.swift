//
//  City.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import Foundation

struct City: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let stations: [Station]
}
