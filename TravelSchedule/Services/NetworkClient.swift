//
//  NetworkClient.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 13.07.2025.
//

import Foundation
import OpenAPIURLSession

enum NetworkError: Error {
    case clientNotInitialized
    case requestInProgress
    case noInternet
    case serverError
}

final actor NetworkClient {
    private let client: Client?
    private let key = Constants.apiKey
    
    private let allStationsService: AllStationsService?
    private let scheduleBetweenStationsService: ScheduleBetweenStationsService?
    
    var isLoadingStations = false
    var isLoadingSchedule = false
    
    init() {
        do {
            self.client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport(),
                middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: key)]
            )
            
            if let client = self.client {
                self.allStationsService = AllStationsService(client: client)
                self.scheduleBetweenStationsService = ScheduleBetweenStationsService(client: client)
            } else {
                self.allStationsService = nil
                self.scheduleBetweenStationsService = nil
            }
        } catch {
            self.client = nil
            self.allStationsService = nil
            self.scheduleBetweenStationsService = nil
        }
    }
    
    func getAllStations() async throws -> AllStations {
        guard let allStationsService = allStationsService else {
            throw NetworkError.clientNotInitialized
        }
        
        guard !isLoadingStations else {
            throw NetworkError.requestInProgress
        }
        
        isLoadingStations = true
        defer { isLoadingStations = false }
        
        do {
            return try await allStationsService.getAllStations()
        } catch {
            throw mapError(error)
        }
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> SearchedRoutes {
        guard let scheduleBetweenStationsService = scheduleBetweenStationsService else {
            throw NetworkError.clientNotInitialized
        }
        
        guard !isLoadingSchedule else {
            throw NetworkError.requestInProgress
        }
        
        isLoadingSchedule = true
        defer { isLoadingSchedule = false }
        
        do {
            return try await scheduleBetweenStationsService.getScheduleBetweenStations(from: from, to: to, date: date)
        } catch {
            throw mapError(error)
        }
    }
}


private extension NetworkClient {
    func mapError(_ error: Error) -> NetworkError {
        if error.localizedDescription.contains(Constants.Errors.noInternetConnection) {
            return .noInternet
        }
        print(error.localizedDescription)
        return .serverError
    }
}
