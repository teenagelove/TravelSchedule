//
//  Story.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import Foundation

struct Story: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let description: String
}
