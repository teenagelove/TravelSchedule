//
//  ScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 02.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchedRoutes = Components.Schemas.SearchedScheduleBetweenStations
typealias StationInfo = Components.Schemas.StationInfo

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> SearchedRoutes
}

actor ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> SearchedRoutes {
        let response = try await client.getScheduleBetweenStations(query: .init(
            from: from,
            to: to,
            date: date
        ))
        
        return try response.ok.body.json
    }
}
