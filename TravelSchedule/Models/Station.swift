//
//  Station.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import Foundation

struct Station: Hashable, Identifiable, Sendable {
    let id = UUID()
    let name: String
    let code: String
}
