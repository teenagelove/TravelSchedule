//
//  APIClientFactory.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 31.05.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

enum APIClientFactory {
    static func makeClient() -> Client? {
        do {
            return Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
        } catch {
            print("Failed to create client: \(error.localizedDescription)")
            return nil
        }
    }
}

