//
//  LocationSelectionButton.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 18.06.2025.
//

import SwiftUI

struct LocationSelectionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .foregroundStyle(
                    !isSelected ? .gray : .black
                )
                .font(.regular17)
        }
    }
}

#Preview {
    LocationSelectionButton(
        title: "Откуда",
        isSelected: false,
        action: {}
    )
}
