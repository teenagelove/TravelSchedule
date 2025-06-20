//
//  Carrier.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//

import Foundation

struct Carrier: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let fullName: String
    let imageName: String
    let email: String?
    let phone: String?
}
