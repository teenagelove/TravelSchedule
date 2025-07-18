//
//  OverlayStatusView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.07.2025.
//

import SwiftUI

struct OverlayStatusView<Content: View>: View {
    let status: LoadingStatus
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            switch status {
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
                    .tint(.primary)
                
            case .networkError:
                NetworkErrorView()
                
            case .serverError:
                ServerErrorView()
                
            case .none:
                content()
            }
        }
    }
}

#Preview {
    OverlayStatusView(
        status: .serverError,
        content: {
            Text("Content goes here")
                .font(.title)
                .padding()
        }
    )
}
