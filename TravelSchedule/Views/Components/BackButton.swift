//
//  BackButton.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import SwiftUI

struct BackButton: View {
    var color: Color = .primary
    var systemName: String = .chevronLeft
    var action: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button(action: {
            action?() ?? dismiss()
        }) {
            Image(systemName: systemName)
                .foregroundColor(color)
                .imageScale(.large)
        }
    }
}

#Preview {
    BackButton()
}
