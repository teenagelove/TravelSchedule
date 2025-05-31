//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 29.05.2025.
//

import SwiftUI

struct ContentView: View {
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
            
            NearestStationsService.testFetchStations(client: client, apiKey: apiKey)
            AllStationsService.testAllStations(client: client, apiKey: apiKey)
            CopyrightService.testGetCopyright(client: client, apiKey: apiKey)
        }
    }
}

#Preview {
    ContentView()
}
