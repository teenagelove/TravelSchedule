//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 14.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var isUserAgreementPresenting = false
    @State private var isServerErrorPresenting = false
    @State private var isNetworkErrorPresenting = false

    var body: some View {
        VStack {
            List {
                Group {
                    Toggle("Темная тема", isOn: $isDarkMode)
                        .tint(.blue)
                        .listRowSeparator(.hidden, edges: .top)
                    // TODO: Implement color scheme toggle
                    //                    .preferredColorScheme(isDarkMode ? .dark : .light)

                    ListRowButton(title: "Пользовательское соглашение") {
                        isUserAgreementPresenting.toggle()
                    }

                    ListRowButton(title: "Показать ошибку сервера") {
                        isServerErrorPresenting.toggle()
                    }

                    ListRowButton(title: "Показать ошибку интернета") {
                        isNetworkErrorPresenting.toggle()
                    }
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
        .padding(.vertical)
        .sheet(isPresented: $isServerErrorPresenting) {
            ServerErrorView()
        }
        .sheet(isPresented: $isNetworkErrorPresenting) {
            NetworkErrorView()
        }
        .fullScreenCover(isPresented: $isUserAgreementPresenting) {
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
