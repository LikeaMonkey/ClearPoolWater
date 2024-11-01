//
//  PoolStatusViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import OSLog
import SwiftUI

@Observable
final class PoolStatusViewModel {
    var skimDate = ""
    var vacuumDate = ""
    var brushDate = ""
    var emptyBasketsDate = ""
    var testWaterDate = ""
    var cleanFilterDate = ""
    var runPumpDate = ""
    var inspectDate = ""

    private(set) var isLoading = false

    let poolId: Int

    private let apiClient: APIClient

    private let logger = Logger(
        subsystem: "com.clear.pool.water.pool.status",
        category: "PoolStatusViewModel"
    )

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

            updateFields(for: poolStatus)

            logger.info("Pool status fetched successfully")
        } catch {
            logger.error("Pool status failed to fetch with error: \(error)")
        }
    }

    private func updateFields(for poolStatus: PoolStatus) {
        withAnimation {
            skimDate = DateUtils.formatDate(poolStatus.skimDate)
            vacuumDate = DateUtils.formatDate(poolStatus.vacuumDate)
            brushDate = DateUtils.formatDate(poolStatus.brushDate)
            emptyBasketsDate = DateUtils.formatDate(poolStatus.emptyBasketsDate)
            testWaterDate = DateUtils.formatDate(poolStatus.testWaterDate)
            cleanFilterDate = DateUtils.formatDate(poolStatus.cleanFilterDate)
            runPumpDate = DateUtils.formatDate(poolStatus.runPumpDate)
            inspectDate = DateUtils.formatDate(poolStatus.inspectDate)
        }
    }
}
