//
//  Constants.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 13.07.2025.
//

import Foundation

enum Constants {
    static let apiKey = "c5b1e7dd-f0cd-4ce6-99e5-7eb487ac23f1"
    static let bufferSize = 50 * 1024 * 1024
    static let ruCode = "l225"
    static let hourK = 60 * 60
    
    enum Sizes {
        static let logoSize: CGFloat = 38
        static let logoRad: CGFloat = 12
        static let imageHeight: CGFloat = 104
    }
    
    enum Errors {
        static let noInternetConnection = "The Internet connection appears to be offline"
    }
}
