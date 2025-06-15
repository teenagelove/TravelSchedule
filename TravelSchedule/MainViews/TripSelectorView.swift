//
//  MainView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 29.05.2025.
//

import SwiftUI

struct TripSelectorView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            guard let client = APIClientFactory.makeClient()
            else { return }
            
            let apiKey = "c5b1e7dd-f0cd-4ce6-99e5-7eb487ac23f1"
            
            // Раскомментировать нужные тесты для запуска
            // Лучше запускать тесты по очереди, чтобы не загромождать консоль выводом
            
//            NearestStationsService.testFetchStations(client: client, apiKey: apiKey)
//            AllStationsService.testAllStations(client: client, apiKey: apiKey)
//            CopyrightService.testGetCopyright(client: client, apiKey: apiKey)
//            StationsOnRouteService.testGetStationOnRoute(client: client, apiKey: apiKey)
//            ScheduleByStationService.testGetScheduleByStation(client: client,apiKey: apiKey)
//            NearestSettlementService.testGetNearestSettlement(client: client, apiKey: apiKey)
//            ScheduleBetweenStationsService.testGetScheduleBetweenStations(client: client, apiKey: apiKey)
//            CarrierService.testGetCarrierByCode(client: client, apiKey: apiKey)
        }
    }
}

#Preview {
    TripSelectorView()
}
