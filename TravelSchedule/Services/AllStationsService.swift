//
//  AllStationsService.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 31.05.2025.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStations

protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> AllStations
}

final class AllStationsService {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(apikey: apiKey))
        
        let responseBody = try response.ok.body.html
        
        let limit = 50 * 1024 * 1024
        
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        
        return try JSONDecoder().decode(AllStations.self, from: fullData)
    }
    
    static func testAllStations(client: Client, apiKey: String) {
        let service = AllStationsService(client: client, apiKey: apiKey)
        
        Task {
            do {
                print("Fetching stations...")
                let allStations = try await service.getAllStations()
//                print("Successfully fetched all stations: \(allStations)")
                print("Successfully fetched all stations: ")
            } catch {
                print("Error fetching stations: \(error.localizedDescription)")
            }
        }
    }
}
