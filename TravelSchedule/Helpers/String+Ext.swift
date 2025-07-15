//
//  String+Ext.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import SwiftUI

extension String {
    static let gearShape = "gearshape.fill"
    static let arrowUp = "arrow.up.message.fill"
    static let chevronRight = "chevron.right"
    static let chevronLeft = "chevron.left"
    static let squarePath = "arrow.2.squarepath"
    static let circle = "circle"
    static let circleFill = "circle.fill"
    static let fillCircle = "largecircle.fill.circle"
    static let checkmarkFill = "checkmark.square.fill"
    static let square = "square"
    static let xmark = "xmark.circle.fill"
    static let airplane = "airplane"
}

extension String {
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMMM"
            outputFormatter.locale = Locale(identifier: "ru_RU")
            return outputFormatter.string(from: date)
        }
        return ""
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            outputFormatter.locale = Locale(identifier: "ru_RU")
            return outputFormatter.string(from: date)
        }
        return ""
    }
    
    var isoDate: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: self)
    }
}
