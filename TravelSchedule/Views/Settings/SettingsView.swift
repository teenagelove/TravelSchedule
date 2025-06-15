//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 14.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Toggle("Темная тема", isOn: $isDarkMode)
                        .tint(.blue)
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                        .listRowSeparator(.hidden, edges: .top)
                    
                    NavigationLink {
                        UserAgreementView()
                            .navigationTitle("Пользовательское соглашение")
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text("Пользовательское соглашение")
                    }
                    .listRowSeparator(.hidden, edges: .all)
                    .foregroundStyle(.primary, .primary)
                }
                .listStyle(.plain)
                
                Spacer()
                
                Group {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .padding(.bottom)
                    Text("Версия 1.0 (beta)")
                }
                .font(.regular12)
            }
            .padding()
        }
        .tint(.primary)
    }
}

#Preview {
    SettingsView()
}
