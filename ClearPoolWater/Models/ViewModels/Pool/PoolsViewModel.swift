//
//  PoolsViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import OSLog
import SwiftUI

@MainActor @Observable
final class PoolsViewModel {
    var pools = [Pool]()
    var waterStatuses = [Int: WaterStatus]()
    var conditions = [Int: PoolCondition]()

    private(set) var state = ViewState.loading

    private let apiClient: APIClient
    private let logger = Logger(
        subsystem: "com.clear.pool.water.pools",
        category: "PoolsViewModel"
    )

    init(apiClient: APIClient = APIManager()) {
        self.apiClient = apiClient
    }

    func fetch() async {
        state = .loading

        do {
            pools = try await fetchPools()
            waterStatuses = try await fetchWaterStatuses()
            conditions = try await fetchConditions()

            state = .success
        } catch {
            state = .failure
            logger.info(
                "Pools data fetch failed with error: \(error.localizedDescription)"
            )
        }
    }

    private func fetchPools() async throws -> [Pool] {
        let pools: [Pool] = try await apiClient.execute(with: PoolResource())
        logger.info("Pools fetched successfully")
        return pools
    }

    private func fetchWaterStatuses() async throws -> [Int: WaterStatus] {
        let waterStatuses: [Int: WaterStatus] = try await withThrowingTaskGroup(
            of: (Int, WaterStatus).self
        ) { [weak self] taskGroup in
            guard let self else { return [:] }

            for pool in pools {
                taskGroup.addTask {
                    let resource = WaterStatusResource(poolId: pool.id)
                    let waterStatus: WaterStatus = try await self.apiClient.execute(with: resource)
                    return (pool.id, waterStatus)
                }
            }

            var waterStatuses = [Int: WaterStatus]()
            for try await (poolId, waterStatus) in taskGroup {
                waterStatuses[poolId] = waterStatus
            }

            return waterStatuses
        }

        logger.info("Pools water statuses fetched successfully")

        return waterStatuses
    }

    private func fetchConditions() async throws -> [Int: PoolCondition] {
        let conditions: [Int: PoolCondition] = try await withThrowingTaskGroup(
            of: (Int, PoolCondition).self
        ) { [weak self] taskGroup in
            guard let self else { return [:] }

            for pool in pools {
                taskGroup.addTask {
                    let resource = PoolTasksResource(poolId: pool.id)
                    let tasks: [PoolTask] = try await self.apiClient.execute(with: resource)
                    let condition = self.condition(for: tasks)
                    return (pool.id, condition)
                }
            }

            var conditions = [Int: PoolCondition]()
            for try await (poolId, condition) in taskGroup {
                conditions[poolId] = condition
            }

            return conditions
        }

        logger.info("Pools conditions fetched successfully")

        return conditions
    }

    // TODO: Remove from VM and put it in separate class
    nonisolated private func condition(for tasks: [PoolTask]) -> PoolCondition {
        let highPriorityTaskCount = tasks.filter { $0.priority == .high }.count
        if highPriorityTaskCount > 0 {
            return .bad
        }

        let mediumPriorityTaskCount = tasks.filter { $0.priority == .medium }.count
        if mediumPriorityTaskCount > 0 {
            return .okay
        }

        return .good
    }

    func deletePool(poolId: Int) async {
        state = .loading

        do {
            let resource = PoolResource(id: poolId, method: .delete)
            let deletedPool: Pool = try await apiClient.execute(with: resource)

            if let poolIndex = pools.firstIndex(where: { $0.id == deletedPool.id }) {
                pools.remove(at: poolIndex)
            }

            state = .success

            logger.info("Pool deleted successfully")
        } catch {
            state = .failure
            logger.error(
                "Pool deletion failed with error: \(error.localizedDescription)"
            )
        }
    }
}
