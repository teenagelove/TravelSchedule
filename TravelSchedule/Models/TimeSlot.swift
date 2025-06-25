//
//  TimeSlot.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 20.06.2025.
//

enum TimeSlot: String, CaseIterable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

// MARK: - Public Methods
extension TimeSlot {
    func contains(time: String) -> Bool {
        guard let hour = extractHour(from: time) else { return false }
        
        switch self {
        case .morning: return hour >= 6 && hour < 12
        case .day: return hour >= 12 && hour < 18
        case .evening: return hour >= 18 && hour < 24
        case .night: return hour >= 0 && hour < 6
        }
    }
}

// MARK: - Private Methods
private extension TimeSlot {
    func extractHour(from timeString: String) -> Int? {
        let components = timeString.split(separator: ":")
        guard let hourString = components.first else { return nil }
        return Int(hourString)
    }
}
