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

final actor AllStationsService: AllStationsServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getAllStations() async throws -> AllStations {
        let response = try await client.getAllStations(query: .init())
        let responseBody = try response.ok.body.html
        let fullData = try await Data(collecting: responseBody, upTo: Constants.bufferSize)
        
        return try JSONDecoder().decode(AllStations.self, from: fullData)
    }
}
