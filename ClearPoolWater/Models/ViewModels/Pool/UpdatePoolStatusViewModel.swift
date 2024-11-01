//
//  UpdatePoolStatusViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import SwiftUI

@Observable
final class UpdatePoolStatusViewModel {
    var skim = false
    var vacuum = false
    var brush = false
    var emptyBaskets = false
    var testWater = false
    var cleanFilter = false
    var runPump = false
    var inspect = false

    private(set) var isLoading = false

    private let poolId: Int
    private var poolStatusId: Int?

    private let apiClient: APIClient

    init(poolId: Int, apiClient: APIClient = APIManager()) {
        self.poolId = poolId
        self.apiClient = apiClient
    }

    func fetchPoolStatus() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let poolStatus: PoolStatus = try await apiClient.execute(
                with: PoolStatusResource(poolId: poolId)
            )
            poolStatusId = poolStatus.id

            updateFields(for: poolStatus)
        } catch {
            assertionFailure("PoolStatusViewModel failed to fetch: \(error)")
        }
    }

    private func updateFields(for poolStatus: PoolStatus) {
        withAnimation {
            skim = DateUtils.isToday(poolStatus.skimDate)
            vacuum = DateUtils.isToday(poolStatus.vacuumDate)
            brush = DateUtils.isToday(poolStatus.brushDate)
            emptyBaskets = DateUtils.isToday(poolStatus.emptyBasketsDate)
            testWater = DateUtils.isToday(poolStatus.testWaterDate)
            cleanFilter = DateUtils.isToday(poolStatus.cleanFilterDate)
            runPump = DateUtils.isToday(poolStatus.runPumpDate)
            inspect = DateUtils.isToday(poolStatus.inspectDate)
        }
    }

    func updatePoolStatus() async {
        guard let poolStatusId else {
            assertionFailure("PoolStatus ID must be set before saving")
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let body = createPoolStatus()
            let _: PoolStatus = try await apiClient.execute(
                with: PoolStatusResource(id: poolStatusId, method: .put, body: body)
            )
        } catch {
            assertionFailure("PoolStatusViewModel failed to save: \(error)")
        }
    }

    private func createPoolStatus() -> PoolStatus.Create {
        PoolStatus.Create(
            skim: skim,
            vacuum: vacuum,
            brush: brush,
            emptyBaskets: emptyBaskets,
            testWater: testWater,
            cleanFilter: cleanFilter,
            runPump: runPump,
            inspect: inspect,
            pool: poolId
        )
    }
}
