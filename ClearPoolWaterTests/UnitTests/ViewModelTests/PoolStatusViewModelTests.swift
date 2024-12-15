//
//  PoolStatusViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Foundation
import Testing

@testable import ClearPoolWater

@MainActor
struct PoolStatusViewModelTests {
    @Test
    func testFetchSuccess() async throws {
        let poolStatus = PoolStatus(
            id: 1,
            skimDate: nil,
            vacuumDate: nil,
            brushDate: nil,
            emptyBasketsDate: nil,
            testWaterDate: nil,
            cleanFilterDate: nil,
            runPumpDate: nil,
            inspectDate: nil
        )
        let model = PoolStatusViewModel(
            poolId: 1,
            apiClient: MockAPIManager(result: poolStatus)
        )

        await model.fetchPoolStatus()

        #expect(model.skimDate == "No Info")
        #expect(model.skimDate == "No Info")
        #expect(model.vacuumDate == "No Info")
        #expect(model.brushDate == "No Info")
        #expect(model.emptyBasketsDate == "No Info")
        #expect(model.testWaterDate == "No Info")
        #expect(model.cleanFilterDate == "No Info")
        #expect(model.runPumpDate == "No Info")
        #expect(model.inspectDate == "No Info")
    }

    @Test
    func testFieldsUpdate() async throws {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let olderDate = try! Date("2024-10-10T00:00:01+0000", strategy: .iso8601)
        let poolStatus = PoolStatus(
            id: 1,
            skimDate: .now,
            vacuumDate: yesterday,
            brushDate: olderDate,
            emptyBasketsDate: nil,
            testWaterDate: nil,
            cleanFilterDate: nil,
            runPumpDate: nil,
            inspectDate: nil
        )
        let model = PoolStatusViewModel(
            poolId: 1,
            apiClient: MockAPIManager(result: poolStatus)
        )

        await model.fetchPoolStatus()

        #expect(model.skimDate == "Today")
        #expect(model.vacuumDate == "Yesterday")
        #expect(model.brushDate == "10.10.2024")
        #expect(model.emptyBasketsDate == "No Info")
        #expect(model.testWaterDate == "No Info")
        #expect(model.cleanFilterDate == "No Info")
        #expect(model.runPumpDate == "No Info")
        #expect(model.inspectDate == "No Info")
    }

    @Test
    func testFetchFailedWithUnexpectedError() async throws {
        let model = PoolStatusViewModel(
            poolId: 1,
            apiClient: MockAPIManager(error: APIError.invalidResponse)
        )

        await model.fetchPoolStatus()

        #expect(model.skimDate == "")
        #expect(model.vacuumDate == "")
        #expect(model.brushDate == "")
        #expect(model.emptyBasketsDate == "")
        #expect(model.testWaterDate == "")
        #expect(model.cleanFilterDate == "")
        #expect(model.runPumpDate == "")
        #expect(model.inspectDate == "")
    }
}
