//
//  Date+Ext.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 13.07.2025.
//

import Foundation

extension Date {
    func toStringFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
