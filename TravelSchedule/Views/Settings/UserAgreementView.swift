//
//  UserAgreementView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 15.06.2025.
//

import SwiftUI

struct UserAgreementView: View {
    var body: some View {
        ScrollView {
            Text(UserAgreement.text)
        }
        .ignoresSafeArea(edges: .bottom)
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
    }
}

#Preview {
    UserAgreementView()
}
