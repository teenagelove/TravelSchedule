//
//  OverlayStatusView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.07.2025.
//

import SwiftUI

struct OverlayStatusView<Content: View>: View {
    let isLoading: Bool
    let isNetworkError: Bool
    let isServerError: Bool
    @ViewBuilder var content: () -> Content

    private var hasErrorOrLoading: Bool {
        isLoading || isServerError || isNetworkError
    }

    var body: some View {
        ZStack {
            if !hasErrorOrLoading {
                content()
            }

            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()
                    .tint(.primary)
            } else if isServerError {
                ServerErrorView()
            } else if isNetworkError {
                NetworkErrorView()
            }
        }
    }
}

#Preview {
    OverlayStatusView(
        isLoading: true,
        isNetworkError: false,
        isServerError: false,
        content: {
            Text("Content goes here")
                .font(.title)
                .padding()
        }
    )
}
