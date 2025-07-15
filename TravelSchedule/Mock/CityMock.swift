//
//  CityMock.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

enum CityMock {
    static let cities: [City] = [
        City(
            name: "Москва",
            stations: [
                Station(name: "Белорусский вокзал", code: "MSK001"),
                Station(name: "Киевский вокзал", code: "MSK002"),
                Station(name: "Курский вокзал", code: "MSK003"),
                Station(name: "Ленинградский вокзал", code: "MSK004"),
                Station(name: "Савёловский вокзал", code: "MSK005"),
                Station(name: "Ярославский вокзал", code: "MSK006"),
                Station(name: "Казанский вокзал", code: "MSK007")
            ]
        )
    ]
}
