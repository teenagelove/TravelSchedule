//
//  TripSelectorView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 29.05.2025.
//

import SwiftUI

struct TripSelectorView: View {
    @State private var selection: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Color.blue
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            NavigationLink(destination: CityPickerView()) {
                                Text("Откуда")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(.gray)
                                    .font(.regular17)
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: CityPickerView()) {
                                Text("Куда")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(.gray)
                                    .font(.regular17)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        Button {
                            // Action for button tap
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 36, height: 36)
                                Image(systemName: .squarePath)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: 128)
                .padding()
                
                Spacer()
            }
        }
        .tint(.primary)
    }
}

#Preview {
    TripSelectorView()
}
