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

    let poolID: Int

    private let apiClient: APIClient
    private let urlProvider: URLProviding

    private let logger = Logger(
        subsystem: "com.clear.pool.water.pool.status",
        category: "PoolStatusViewModel"
    )

    init(
        poolID: Int,
        apiClient: APIClient = NetworkManager(),
        urlProvider: URLProviding = URLProvider()
    ) {
        self.poolID = poolID

        self.apiClient = apiClient
        self.urlProvider = urlProvider
    }

    func fetch() async {
        do {
            let url: URL = urlProvider.poolStatusURL(poolId: poolID)
            let poolStatus: PoolStatus = try await apiClient.get(url: url, headers: nil)
            updateFields(for: poolStatus)
            logger.info("Pool status fetched successfully")
        } catch {
            logger.error("Pool status failed to fetch with error: \(error)")
        }
    }

    private func updateFields(for poolStatus: PoolStatus) {
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
