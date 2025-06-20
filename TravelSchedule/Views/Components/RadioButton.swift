//
//  RadioButton.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 20.06.2025.
//

import SwiftUI

struct RadioButton: View {
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
                Image(systemName: isSelected ? .fillCircle : .circle)
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
    RadioButton(
        title: "Option 1",
        isSelected: true,
        onTap: {
            print("Tapped Option 1")
        }
    )
}
