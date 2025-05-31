//
//  NearestStationsService.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 31.05.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService: NearestStationsServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
                apikey: apiKey,
                lat: lat,
                lng: lng,
                distance: distance
            )
        )
        
        return try response.ok.body.json
    }
    
    static func testFetchStations(client: Client, apiKey: String) {
        let service = NearestStationsService(client: client, apiKey: apiKey)
        
        Task {
            do {
                print("Fetching stations...")
                
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                
//                print("Successfully fetched stations: \(stations)")
                print("Successfully fetched stations:")
            } catch {
                print("Error fetching stations: \(error.localizedDescription)")
            }
        }
    }
}
