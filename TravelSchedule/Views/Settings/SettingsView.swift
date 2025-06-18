//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 14.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showUserAgreement = false

    var body: some View {
        VStack {
            List {
                Toggle("Темная тема", isOn: $isDarkMode)
                    .tint(.blue)
                    .listRowSeparator(.hidden, edges: .top)

                ListRowButton(title: "Пользовательское соглашение") {
                    showUserAgreement.toggle()
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
        .fullScreenCover(isPresented: $showUserAgreement) {
            NavigationStack {
                UserAgreementView()
                    .navigationTitle("Пользовательское соглашение")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    SettingsView()
}
