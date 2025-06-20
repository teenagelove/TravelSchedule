//
//  TimeSlotRow.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 20.06.2025.
//

import SwiftUI

struct TimeSlotRow: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(.regular17)
                .foregroundStyle(.primary)

            Spacer()

            Button(action: onTap) {
                Image(systemName: isSelected ? .checkmarkFill : .square)
                    .font(.system(size: 24))
                    .foregroundColor(.primary)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    TimeSlotRow(
        title: "08:00 - 10:00",
        isSelected: true
    ) {
        print("Tapped")
    }
}
