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
                Station(name: "Белорусский вокзал"),
                Station(name: "Киевский вокзал"),
                Station(name: "Курский вокзал"),
                Station(name: "Ленинградский вокзал"),
                Station(name: "Савёловский вокзал"),
                Station(name: "Ярославский вокзал"),
                Station(name: "Казанский вокзал")
            ]
        ),
        City(
            name: "Санкт-Петербург",
            stations: [
                Station(name: "Балтийский вокзал"),
                Station(name: "Ладожский вокзал"),
                Station(name: "Московский вокзал"),
                Station(name: "Варшавский вокзал"),
                Station(name: "Витебский вокзал")
            ]
        ),
        City(
            name: "Сочи",
            stations: [
                Station(name: "Сочи вокзал"),
                Station(name: "Адлер"),
                Station(name: "Дагомыс"),
                Station(name: "Мацеста"),
                Station(name: "Лоо"),
                Station(name: "Хоста")
            ]
        ),
        City(
            name: "Горный воздух",
            stations: [
                Station(name: "Городской ж/д вокзал"),
                Station(name: "Горячий Ключ"),
                Station(name: "Динская"),
                Station(name: "Сады"),
                Station(name: "МЖК")
            ]
        ),
        City(
            name: "Краснодар",
            stations: [
                Station(name: "Краснодар‑1"),
                Station(name: "Краснодар‑2"),
                Station(name: "Пашковская"),
                Station(name: "Краснодар‑Сортировочный"),
                Station(name: "Динская"),
                Station(name: "Остановочный пункт 666 км")
            ]
        ),
        City(
            name: "Казань",
            stations: [
                Station(name: "Казань-Пассажирская"),
                Station(name: "Казань‑1"),
                Station(name: "Казань‑2"),
                Station(name: "Суконная Слобода"),
                Station(name: "Юдино")
            ]
        ),
        City(
            name: "Омск",
            stations: [
                Station(name: "Омск‑Пассажирский"),
                Station(name: "Комбинатская"),
                Station(name: "Московка"),
                Station(name: "Калачинская"),
                Station(name: "Омск‑2")
            ]
        )
    ]
}
