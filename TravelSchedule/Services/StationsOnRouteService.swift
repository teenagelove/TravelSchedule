//
//  StationsOnRouteService.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 02.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationsOnRoute = Components.Schemas.StationsOnRoute

protocol StationsOnRouteServiceProtocol {
    func getStationOnRoute(uid: String) async throws -> StationsOnRoute
}

final class StationsOnRouteService: StationsOnRouteServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getStationOnRoute(uid: String) async throws -> StationsOnRoute {
        let response = try await client.getStationsOnRoute(query: .init(
            apikey: apiKey,
            uid: uid
        ))
        
        return try response.ok.body.json
    }
    
    static func testGetStationOnRoute(client: Client, apiKey: String) {
        let service = StationsOnRouteService(client: client, apiKey: apiKey)
        
        Task {
            do {
                print("Fetching stations on route...")
                let uid = "FV-6365_260109_c8565_12" // Example UID
                let stationsOnRoute = try await service.getStationOnRoute(uid: uid)
                print("Successfully fetched stations on route: \(stationsOnRoute)")
//                print("Successfully fetched stations on route!")
            } catch {
                print("Error fetching stations on route: \(error.localizedDescription)")
            }
        }
    }
}
