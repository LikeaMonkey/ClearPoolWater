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

    private(set) var isLoading = false
    private(set) var errorMessage: String?

    let poolId: Int

    private let authManager: AuthManaging
    private let apiClient: APIClient

    private let logger = Logger(
        subsystem: "com.clear.pool.water.pool.tasks",
        category: "PoolTasksViewModel"
    )

    init(
        poolId: Int,
        authManager: AuthManaging = AuthManager.shared,
        apiClient: APIClient = APIManager()
    ) {
        self.poolId = poolId
        self.authManager = authManager
        self.apiClient = apiClient
    }

    func fetchPoolTasks() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let tasks: [PoolTask] = try await apiClient.execute(
                with: PoolTasksResource(poolId: poolId)
            )

            updateFields(with: tasks)

            logger.info("Pool tasks fetched successfully")
            logger.info("Pool tasks \(tasks)")
        } catch {
            logger.error("Pool tasks fetching failed with error: \(error)")
        }
    }

    private func updateFields(with tasks: [PoolTask]) {
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
}
