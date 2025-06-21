//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 14.06.2025.
//

import SwiftUI

struct MainTabView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool?
    
    var body: some View {
        TabView {
            TripSelectorView()
                .tabItem {
                    Label("", systemImage: .arrowUp)
                }
            SettingsView(isDarkMode: $isDarkMode)
                .tabItem {
                    Label("", systemImage: .gearShape)
                }
        }
        .tint(.primary)
        .safeAreaInset(edge: .bottom) {
            Divider()
                .padding(.bottom, 60)
        }
        .preferredColorScheme(
            isDarkMode == true ? .dark :
            isDarkMode == false ? .light : nil
        )
    }
}

#Preview {
    MainTabView()
}
