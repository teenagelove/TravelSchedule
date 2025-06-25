//
//  RouteMock.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//


enum RouteMock {
    static let routes: [Route] = [
        Route(
            carrier: CarrierMock.carriers[0], // РЖД
            date: "14 января",
            startingTime: "22:30",
            arrivalTime: "08:15",
            travelTime: "20 часов",
            transfer: "С пересадкой в Костроме"
        ),
        Route(
            carrier: CarrierMock.carriers[1], // ФГК
            date: "15 января",
            startingTime: "01:15",
            arrivalTime: "09:00",
            travelTime: "9 часов",
            transfer: nil
        ),
        Route(
            carrier: CarrierMock.carriers[2], // Урал логистика
            date: "16 января",
            startingTime: "12:30",
            arrivalTime: "21:00",
            travelTime: "9 часов",
            transfer: nil
        ),
        Route(
            carrier: CarrierMock.carriers[0], // РЖД
            date: "17 января",
            startingTime: "22:30",
            arrivalTime: "08:15",
            travelTime: "20 часов",
            transfer: "С пересадкой в Костроме"
        ),
        Route(
            carrier: CarrierMock.carriers[0], // РЖД
            date: "17 января",
            startingTime: "12:30",
            arrivalTime: "10:30",
            travelTime: "22 часа",
            transfer: nil
        ),
        Route(
            carrier: CarrierMock.carriers[1], // ФГ
            date: "17 января",
            startingTime: "12:30",
            arrivalTime: "16:30",
            travelTime: "4 часа",
            transfer: "С пересадкой в Костроме"
        ),
        Route(
            carrier: CarrierMock.carriers[2], // Урал логистика
            date: "17 января",
            startingTime: "14:30",
            arrivalTime: "15:30",
            travelTime: "1 часа",
            transfer: nil
        )
    ]
}
