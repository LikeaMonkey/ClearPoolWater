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

    private(set) var state = ViewState.loading

    private let apiClient: APIClient
    private let logger = Logger(
        subsystem: "com.clear.pool.water.pools",
        category: "PoolsViewModel"
    )

    init(apiClient: APIClient = APIManager()) {
        self.apiClient = apiClient
    }

    func fetchPools() async {
        state = .loading

        do {
            pools = try await apiClient.execute(with: PoolResource())
            state = .success

            logger.info("Pools fetched successfully")
        } catch {
            state = .failure
            logger.error(
                "Pools fetch failed with error: \(error.localizedDescription)"
            )
        }
    }
}
