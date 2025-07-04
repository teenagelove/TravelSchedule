//
//  CloseButton.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: .xmark)
                .font(.bold24)
                .foregroundColor(.black)
                .background(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                )
        }
    }
}

#Preview {
    CloseButton()
}
