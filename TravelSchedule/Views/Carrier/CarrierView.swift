//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 20.06.2025.
//

import SwiftUI

struct CarrierView: View {
    var carrier: Carrier
    
    var body: some View {
        VStack(spacing: 16) {
            Image(carrier.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 104)
                
            VStack(alignment: .leading, spacing: 16) {
                Text(carrier.fullName)
                    .font(.bold24)
                    .foregroundStyle(.primary)
                
                VStack(spacing: 16) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("E-mail")
                                .font(.regular17)
                                .foregroundStyle(.primary)
                            if let email = carrier.email {
                                Text(email)
                                    .font(.regular12)
                                    .foregroundStyle(.blue)
                            }
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Телефон")
                                .font(.regular17)
                                .foregroundStyle(.primary)
                            
                            if let phone = carrier.phone {
                                Text(phone)
                                    .font(.regular12)
                                    .foregroundStyle(.blue)
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
    }
}

#Preview {
    CarrierView(carrier: CarrierMock.carriers[0])
}
