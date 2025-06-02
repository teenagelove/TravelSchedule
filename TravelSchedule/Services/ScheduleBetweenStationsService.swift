//
//  ScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 02.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStations = Components.Schemas.SearchedScheduleBetweenStations

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> ScheduleBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apiKey,
            from: from,
            to: to,
            date: date
        ))
        
        return try response.ok.body.json
    }
    
    static func testGetScheduleBetweenStations(client: Client, apiKey: String) {
        let service = ScheduleBetweenStationsService(client: client, apiKey: apiKey)
        
        Task {
            do {
                print("Fetching schedule between stations...")
                let schedule = try await service.getScheduleBetweenStations(
                    from: "c146",
                    to: "c213",
                    date: "2025-09-09"
                ) // Example station codes and date
                print("Successfully fetched schedule between stations: \(schedule)")
            } catch {
                print("Error fetching schedule between stations: \(error.localizedDescription)")
            }
        }
    }
}
