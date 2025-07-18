//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 14.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: SettingsViewModel
    @Environment(\.colorScheme) private var systemScheme

    var body: some View {
        VStack {
            List {
                Group {
                    Toggle("Темная тема", isOn: viewModel.toggleBinding(systemScheme: systemScheme))
                        .tint(.blue)
                        .listRowSeparator(.hidden, edges: .top)

                    ListRowButton(title: "Пользовательское соглашение") {
                        viewModel.isUserAgreementPresenting = true
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
        .fullScreenCover(isPresented: $viewModel.isUserAgreementPresenting) {
            NavigationStack {
                UserAgreementView()
                    .navigationTitle("Пользовательское соглашение")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
