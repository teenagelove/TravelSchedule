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

extension Route {
    init?(segment: Segment) {
        guard
            let date = segment.start_date,
            let startingTime = segment.departure,
            let arrival = segment.arrival,
            let duration = segment.duration,
            let transfer = segment.has_transfers,
            let carrierInfo = segment.thread?.carrier,
            let carrierCode = carrierInfo.code,
            let carrierFullName = carrierInfo.title
        else { return nil }

        let carrier = Carrier(
            name: carrierFullName,
            fullName: carrierFullName,
            imageName: carrierInfo.logo ?? "",
            email: carrierInfo.email,
            phone: carrierInfo.phone
        )

        self.code = carrierCode
        self.carrier = carrier
        self.date = date
        self.startingTime = startingTime
        self.arrivalTime = arrival
        self.travelTime = duration
        self.transfer = transfer
    }
}
