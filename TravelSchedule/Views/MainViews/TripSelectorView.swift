//
//  TripSelectorView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 29.05.2025.
//

import SwiftUI

enum LocationRoute: Hashable {
    case origin
    case destination
}

struct TripSelectorView: View {
    @State private var viewModel: ViewModel = ViewModel()
    @State private var path: [LocationRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ZStack {
                    Color.blue
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Button {
                                path.append(.origin)
                            } label: {
                                Text(viewModel.originName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(
                                        !viewModel.isOriginSelected ? .gray : .primary
                                    )
                                    .font(.regular17)
                            }
                            
                            Spacer()
                            
                            Button {
                                path.append(.destination)
                            } label: {
                                Text(viewModel.destinationName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(
                                        !viewModel.isDestinationSelected ? .gray : .primary
                                    )
                                    .font(.regular17)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        Button {
                            viewModel.switchOriginDestination()
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
            .navigationDestination(for: LocationRoute.self) { route in
                switch route {
                case .origin:
                    LocationPickerView(viewModel: $viewModel, isOrigin: true, path: $path)
                case .destination:
                    LocationPickerView(viewModel: $viewModel, isOrigin: false, path: $path)
                }
            }
        }
        .tint(.primary)
    }
}

#Preview {
    TripSelectorView()
}
