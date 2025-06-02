//
//  NearestSettlementService.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 02.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestSettlement = Components.Schemas.Settlement

protocol NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement
}

final class NearestSettlementService: NearestSettlementServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlement {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng
        ))
        
        return try response.ok.body.json
    }
    
    static func testGetNearestSettlement(client: Client, apiKey: String) {
        let service = NearestSettlementService(client: client, apiKey: apiKey)
        
        Task {
            do {
                print("Fetching nearest settlement...")
                let settlement = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163)
                print("Successfully fetched nearest settlement: \(settlement)")
            } catch {
                print("Error fetching nearest settlement: \(error.localizedDescription)")
            }
        }
    }
}
