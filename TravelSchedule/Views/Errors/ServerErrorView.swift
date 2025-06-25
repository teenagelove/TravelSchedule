//
//  ServerErrorView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 20.06.2025.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        VStack {
            Image(.serverError)
                .padding()
            Text("Ошибка сервера")
                .font(.bold24)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    ServerErrorView()
}
