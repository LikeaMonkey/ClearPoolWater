//
//  PoolTasksViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 23.10.24.
//

import OSLog
import SwiftUI

@Observable
final class PoolTasksViewModel {
    var cleaningTasks = [PoolTask]()
    var maintenanceTasks = [PoolTask]()
    var testingTasks = [PoolTask]()

    private(set) var state = ViewState.loading

    let poolId: Int

    private let apiClient: APIClient

    private let logger = Logger(
        subsystem: "com.clear.pool.water.pool.tasks",
        category: "PoolTasksViewModel"
    )

    init(poolId: Int, apiClient: APIClient = APIManager()) {
        self.poolId = poolId
        self.apiClient = apiClient
    }

    func fetchPoolTasks() async {
        state = .loading

        do {
            try await performFetchPoolTasksRequest()
        } catch {
            handleError(error)
        }
    }

    private func performFetchPoolTasksRequest() async throws {
        let tasks: [PoolTask] = try await apiClient.execute(
            with: PoolTasksResource(poolId: poolId)
        )

        updateTasks(tasks)

        state = .success

        logger.info("Pool tasks fetched successfully")
        logger.debug("Pool tasks \(tasks)")
    }

    private func updateTasks(_ tasks: [PoolTask]) {
        maintenanceTasks =
            tasks
            .filter { $0.type == .maintenance }
            .sorted { $0.priority > $1.priority }

        cleaningTasks =
            tasks
            .filter { $0.type == .cleaning }
            .sorted { $0.priority > $1.priority }

        testingTasks =
            tasks
            .filter { $0.type == .testing }
            .sorted { $0.priority > $1.priority }
    }

    private func handleError(_ error: Error) {
        state = .failure

        logger.error(
            "Pool tasks fetching failed with error: \(error.localizedDescription)"
        )
    }
}
