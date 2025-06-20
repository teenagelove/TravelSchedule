//
//  BlueLabel.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 20.06.2025.
//

import SwiftUI

struct BlueLabel: View {
    let text: String
    var isFilterApplied: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            Text(text)
                .font(.bold17)
                .foregroundStyle(.white)

            if isFilterApplied {
                Image(systemName: .circleFill)
                    .foregroundStyle(.ypRed)
                    .font(.system(size: 8))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        .background(.blue)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    BlueLabel(text: "Принять", isFilterApplied: true)
}
