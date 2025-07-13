//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 13.07.2025.
//

import SwiftUI

@MainActor
@Observable
final class SettingsViewModel {

    // MARK: - Properties
    @ObservationIgnored
    @AppStorage("isDarkMode") private var storedDarkMode: Bool?
    private var _isDarkMode: Bool?

    // MARK: - Screens
    var isUserAgreementPresenting = false
    var isServerErrorPresenting = false
    var isNetworkErrorPresenting = false

    // MARK: - Initialization
    init() {
        _isDarkMode = storedDarkMode
    }

    // MARK: - Theme Management
    var isDarkMode: Bool? {
        get { _isDarkMode }
        set {
            _isDarkMode = newValue
            storedDarkMode = newValue
        }
    }

    var preferredColorScheme: ColorScheme? {
        guard let isDarkMode = _isDarkMode else { return nil }
        return isDarkMode ? .dark : .light
    }

    func toggleState(systemScheme: ColorScheme) -> Bool {
        return _isDarkMode ?? (systemScheme == .dark)
    }

    func toggleBinding(systemScheme: ColorScheme) -> Binding<Bool> {
        Binding(
            get: { self.toggleState(systemScheme: systemScheme) },
            set: { self.toggleDarkMode(to: $0) }
        )
    }

    // MARK: - Actions
    func toggleDarkMode(to value: Bool) {
        isDarkMode = value
    }
}
