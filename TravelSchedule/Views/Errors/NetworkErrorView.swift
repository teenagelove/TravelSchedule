//
//  NetworkErrorView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 20.06.2025.
//

import SwiftUI

struct NetworkErrorView: View {
    var body: some View {
        VStack {
            Image(.networkError)
                .padding()
            Text("Нет интернета")
                .font(.bold24)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    NetworkErrorView()
}
