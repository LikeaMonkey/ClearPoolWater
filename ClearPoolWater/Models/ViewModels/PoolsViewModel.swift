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
    private let urlProvider: URLProviding

    private let logger = Logger(subsystem: "com.clear.pool.water.pools", category: "PoolsViewModel")

    init(
        authManager: AuthManaging = AuthManager.shared,
        apiClient: APIClient = NetworkManager(),
        urlProvider: URLProviding = URLProvider()
    ) {
        self.authManager = authManager
        self.apiClient = apiClient
        self.urlProvider = urlProvider
    }

    func fetch() async {
        guard let userId = authManager.userId else {
            logger.error("User ID is not set")
            return
        }

        do {
            let url: URL = urlProvider.poolsURL(userId: userId)
            pools = try await apiClient.get(url: url, headers: nil)
            logger.info("Pools fetched successfully")
        } catch {
            logger.error("Pools fetch failed with error: \(error)")
        }
    }
}
