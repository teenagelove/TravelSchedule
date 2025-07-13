//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 14.06.2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var settingsViewModel = SettingsViewModel()
    @State private var networkClient = NetworkClient()

    var body: some View {
        TabView {
            TripSelectorView()
                .tabItem {
                    Label("", systemImage: .arrowUp)
                }
            SettingsView(viewModel: settingsViewModel)
                .tabItem {
                    Label("", systemImage: .gearShape)
                }
        }
        .tint(.primary)
        .safeAreaInset(edge: .bottom) {
            Divider()
                .padding(.bottom, 60)
        }
        .preferredColorScheme(settingsViewModel.preferredColorScheme)
        .task {
            
        }
    }
}

#Preview {
    MainTabView()
}
