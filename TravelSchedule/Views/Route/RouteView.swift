//
//  RouteView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 19.06.2025.
//

import SwiftUI

struct RouteView: View {
    let route: Route

    var body: some View {
        ZStack {
            Color.ypLightGray
            VStack {
                HStack {
                    Image(route.carrier.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)

                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(route.carrier.name)
                                .font(.regular17)
                                .foregroundStyle(.black)

                            if let transfer = route.transfer {
                                Text(transfer)
                                    .font(.regular12)
                                    .foregroundStyle(.ypRed)
                            }
                        }

                        Spacer()

                        Text(route.date)
                            .font(.regular12)
                            .foregroundStyle(.black)
                    }
                }

                HStack {
                    HStack {
                        Text(route.startingTime)
                            .font(.regular17)
                            .foregroundStyle(.black)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                    Text(route.travelTime)
                        .font(.regular12)
                        .foregroundStyle(.black)
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        Text(route.arrivalTime)
                            .font(.regular17)
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding()
        }
        .clipShape(.rect(cornerRadius: 24))
    }
}

#Preview {
    RouteView(route: RouteMock.routes[0])
}
