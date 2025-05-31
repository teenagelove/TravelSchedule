//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 31.05.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(apikey: apiKey))
        return try response.ok.body.json
    }
    
    static func testGetCopyright(client: Client, apiKey: String) {
        let service = CopyrightService(client: client, apiKey: apiKey)
        
        Task {
            do {
                print("Fetching copyright...")
                let copyright = try await service.getCopyright()
//                print("Successfully fetched copyright: \(copyright)")
                print("Successfully fetched copyright: ")
            } catch {
                print("Error fetching copyright: \(error.localizedDescription)")
            }
        }
    }
}
