//
//  CreatePoolViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import OSLog
import SwiftUI

@Observable
final class CreatePoolViewModel {
    var name = ""
    var waterLevel = 80
    var waterCapacity = 5.0
    var filterType = Pool.FilterType.sand

    private let authManager: AuthManaging
    private let apiClient: APIClient
    private let urlProvider: URLProviding

    private let logger = Logger(
        subsystem: "com.clear.pool.water.create.pool",
        category: "CreatePoolViewModel"
    )

    init(
        authManager: AuthManaging = AuthManager.shared,
        apiClient: APIClient = NetworkManager(),
        urlProvider: URLProviding = URLProvider()
    ) {
        self.authManager = authManager
        self.apiClient = apiClient
        self.urlProvider = urlProvider
    }

    func addNewPool() async {
        guard let createPool = createPool() else {
            logger.error("Pool must be created")
            return
        }

        do {
            let url: URL = urlProvider.poolsURL
            let _: Pool = try await apiClient.post(
                url: url,
                body: createPool,
                headers: nil
            )
            logger.info("Pool created successfully")
        } catch {
            logger.error("Pool creation failed with error: \(error)")
        }
    }

    private func createPool() -> Pool.Create? {
        guard let userId = authManager.userId else {
            logger.error("User must be logged in")
            return nil
        }
        guard !name.isEmpty else {
            logger.error("Pool name cannot be empty")
            return nil
        }

        let waterLevel = Double(waterLevel) / 100

        return Pool.Create(
            name: name,
            waterLevel: waterLevel,
            waterCapacity: waterCapacity,
            filterType: filterType,
            user: userId
        )
    }
}
