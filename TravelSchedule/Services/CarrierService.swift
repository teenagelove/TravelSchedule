//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 02.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Carriers = Components.Schemas.Carriers

protocol CarrierServiceProtocol {
    func getCarriersByCode(code: Int) async throws -> Carriers
}

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getCarriersByCode(code: Int) async throws -> Carriers {
        let response = try await client.getCarriersByCode(query: .init(apikey: apiKey, code: code))
        return try response.ok.body.json
    }
    
    static func testGetCarrierByCode(client: Client, apiKey: String) {
        let service = CarrierService(client: client, apiKey: apiKey)
        
        Task {
            do {
                print("Fetching carrier by code...")
                let carriers = try await service.getCarriersByCode(code: 680) // Example carrier code
                print("Successfully fetched carrier by code: \(carriers)")
            } catch {
                print("Error fetching carrier by code: \(error.localizedDescription)")
            }
        }
    }
}
