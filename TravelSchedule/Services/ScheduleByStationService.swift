//
//  ScheduleByStationService.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 02.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleByStation = Components.Schemas.ScheduleByStation

protocol ScheduleByStationServiceProtocol {
    func getScheduleByStation(stationCode: String, transportType: String?) async throws -> ScheduleByStation
}

final class ScheduleByStationService: ScheduleByStationServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getScheduleByStation(stationCode: String, transportType: String? = nil) async throws -> ScheduleByStation {
        let response = try await client.getScheduleByStation(query: .init(
            apikey: apiKey,
            station: stationCode,
            transport_types: transportType
        ))
        
        return try response.ok.body.json
    }
    
    static func testGetScheduleByStation(client: Client, apiKey: String) {
        let service = ScheduleByStationService(client: client, apiKey: apiKey)
        
        Task {
            do {
                print("Fetching schedule by station...")
                let stationCode = "s9600213" // Example station code
                let schedule = try await service.getScheduleByStation(
                    stationCode: stationCode,
                    transportType: "suburban" // Example transport type
                )
                print("Successfully fetched schedule by station: \(schedule)")
            } catch {
                print("Error fetching schedule by station: \(error.localizedDescription)")
            }
        }
    }
}
