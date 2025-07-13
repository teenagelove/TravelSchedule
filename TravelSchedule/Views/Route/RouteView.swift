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
                    imageView

                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(route.carrier.name)
                                .font(.regular17)
                                .foregroundStyle(.black)

                            if route.transfer {
                                Text("С пересадкой")
                                    .font(.regular12)
                                    .foregroundStyle(.ypRed)
                            }
                        }

                        Spacer()

                        Text(route.date.toDateFormat())
                            .font(.regular12)
                            .foregroundStyle(.black)
                    }
                }

                HStack {
                    HStack {
                        Text(route.startingTime.toTimeFormat())
                            .font(.regular17)
                            .foregroundStyle(.black)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    }
                    Text("\(route.travelTime / Constants.hourK) часов")
                        .font(.regular12)
                        .foregroundStyle(.black)
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                        Text(route.arrivalTime.toTimeFormat())
                            .font(.regular17)
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding()
        }
        .clipShape(.rect(cornerRadius: 24))
    }

    @ViewBuilder
    private var imageView: some View {
        if !route.carrier.imageName.isEmpty {
            AsyncImage(url: URL(string: route.carrier.imageName)) { image in
                Color.white
                    .frame(
                        width: Constants.sizes.logoSize,
                        height: Constants.sizes.logoSize
                    )
                    .clipShape(.rect(cornerRadius: Constants.sizes.logoRad))
                    .overlay(
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(
                                .rect(cornerRadius: Constants.sizes.logoRad)
                            )
                    )
            } placeholder: {
                ProgressView()
                    .frame(
                        width: Constants.sizes.logoSize,
                        height: Constants.sizes.logoSize
                    )
            }
        } else {
            Image(systemName: .airplane)
                .resizable()
                .scaledToFit()
                .frame(
                    width: Constants.sizes.logoSize,
                    height: Constants.sizes.logoSize
                )
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    RouteView(route: RouteMock.route)
}
