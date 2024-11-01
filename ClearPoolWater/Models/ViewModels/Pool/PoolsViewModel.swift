//
//  PoolsViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import OSLog
import SwiftUI

@Observable
final class PoolsViewModel {
    var pools = [Pool]()

    private let authManager: AuthManaging
    private let apiClient: APIClient

    private let logger = Logger(subsystem: "com.clear.pool.water.pools", category: "PoolsViewModel")

    init(
        authManager: AuthManaging = AuthManager.shared,
        apiClient: APIClient = APIManager()
    ) {
        self.authManager = authManager
        self.apiClient = apiClient
    }

    func fetchPools() async {
        guard let userId = authManager.userId else {
            logger.error("User ID is not set")
            return
        }

        do {
            pools = try await apiClient.execute(with: PoolResource(userId: userId))
            logger.info("Pools fetched successfully")
        } catch {
            logger.error("Pools fetch failed with error: \(error)")
        }
    }
}