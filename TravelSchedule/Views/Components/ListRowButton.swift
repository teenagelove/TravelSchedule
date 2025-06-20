//
//  ListRowButton.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 18.06.2025.
//

import SwiftUI

struct ListRowButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.regular17)
                Spacer()
                Image(systemName: .chevronRight)
                    .foregroundColor(.primary)
                    .font(.system(size: 24))
            }
            .contentShape(.rect())
        }
    }
}

#Preview {
    ListRowButton(
        title: "Пользовательское соглашение",
        action: {
            print("Button tapped")
        }
    )
}
