//
//  CreatePoolViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import OSLog
import SwiftUI

@MainActor @Observable
final class CreatePoolViewModel {
    var name = ""
    var waterLevel = 0.8
    var waterCapacity = 10.0
    var filterType = Pool.FilterType.sand

    private let authManager: AuthManaging
    private let apiClient: APIClient

    private let logger = Logger(
        subsystem: "com.clear.pool.water.create.pool",
        category: "CreatePoolViewModel"
    )

    init(
        authManager: AuthManaging = AuthManager.shared,
        apiClient: APIClient = APIManager()
    ) {
        self.authManager = authManager
        self.apiClient = apiClient
    }

    func addNewPool() async {
        guard let createPool = createPool() else {
            logger.error("Pool must be created")
            return
        }

        do {
            let poolResource = PoolResource(method: .post, body: createPool)
            let _: Pool = try await apiClient.execute(with: poolResource)
            logger.info("Pool created successfully")
        } catch {
            logger.error("Pool creation failed with error: \(error)")
        }
    }

    private func createPool() -> Pool.Create? {
        guard authManager.isLoggedIn else {
            logger.error("User must be logged in")
            return nil
        }

        guard !name.isEmpty else {
            logger.error("Pool name cannot be empty")
            return nil
        }

        return Pool.Create(
            name: name,
            waterLevel: waterLevel,
            waterCapacity: waterCapacity,
            filterType: filterType
        )
    }
}
