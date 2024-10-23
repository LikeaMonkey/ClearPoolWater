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

    private let poolID: Int
    private var poolStatusId: Int?

    private let apiClient: APIClient
    private let urlProvider: URLProviding

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
            poolStatusId = poolStatus.id
            updateFields(for: poolStatus)
        } catch {
            assertionFailure("PoolStatusViewModel failed to fetch: \(error)")
        }
    }

    private func updateFields(for poolStatus: PoolStatus) {
        skim = DateUtils.isToday(poolStatus.skimDate)
        vacuum = DateUtils.isToday(poolStatus.vacuumDate)
        brush = DateUtils.isToday(poolStatus.brushDate)
        emptyBaskets = DateUtils.isToday(poolStatus.emptyBasketsDate)
        testWater = DateUtils.isToday(poolStatus.testWaterDate)
        cleanFilter = DateUtils.isToday(poolStatus.cleanFilterDate)
        runPump = DateUtils.isToday(poolStatus.runPumpDate)
        inspect = DateUtils.isToday(poolStatus.inspectDate)
    }

    func save() async {
        guard let poolStatusId else {
            assertionFailure("PoolStatus ID must be set before saving")
            return
        }

        do {
            let url: URL = urlProvider.poolStatusURL(poolStatusId: poolStatusId)
            let body = createPoolStatus()
            let _: PoolStatus = try await apiClient.put(url: url, body: body, headers: nil)
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
            pool: poolID
        )
    }
}
