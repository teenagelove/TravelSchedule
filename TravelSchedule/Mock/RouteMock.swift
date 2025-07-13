//
//  RouteMock.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//


enum RouteMock {
    static let route = Route(
        code: 123456,
        carrier: CarrierMock.carrier,
        date: "2025-07-14",
        startingTime: "2025-07-14T01:00:00+03:00",
        arrivalTime: "2025-07-14T10:41:00+03:00",
        travelTime: 34860,
        transfer: true
    )
}
