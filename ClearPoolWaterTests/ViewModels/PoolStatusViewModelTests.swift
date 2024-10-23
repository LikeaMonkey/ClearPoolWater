//
//  PoolStatusViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Foundation
import Testing

@testable import ClearPoolWater

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
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = poolStatus

        let poolStatusViewModel = PoolStatusViewModel(
            poolID: 1,
            apiClient: mockNetworkManager
        )

        await poolStatusViewModel.fetch()

        #expect(poolStatusViewModel.skimDate == "No Info")
        #expect(poolStatusViewModel.skimDate == "No Info")
        #expect(poolStatusViewModel.vacuumDate == "No Info")
        #expect(poolStatusViewModel.brushDate == "No Info")
        #expect(poolStatusViewModel.emptyBasketsDate == "No Info")
        #expect(poolStatusViewModel.testWaterDate == "No Info")
        #expect(poolStatusViewModel.cleanFilterDate == "No Info")
        #expect(poolStatusViewModel.runPumpDate == "No Info")
        #expect(poolStatusViewModel.inspectDate == "No Info")
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
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = poolStatus

        let poolStatusViewModel = PoolStatusViewModel(
            poolID: 1,
            apiClient: mockNetworkManager
        )

        await poolStatusViewModel.fetch()

        #expect(poolStatusViewModel.skimDate == "Today")
        #expect(poolStatusViewModel.vacuumDate == "Yesterday")
        #expect(poolStatusViewModel.brushDate == "10.10.2024")
        #expect(poolStatusViewModel.emptyBasketsDate == "No Info")
        #expect(poolStatusViewModel.testWaterDate == "No Info")
        #expect(poolStatusViewModel.cleanFilterDate == "No Info")
        #expect(poolStatusViewModel.runPumpDate == "No Info")
        #expect(poolStatusViewModel.inspectDate == "No Info")
    }

    @Test
    func testFetchFailedWithUnexpectedError() async throws {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.errorToThrow = NetworkError.invalidResponse

        let poolStatusViewModel = PoolStatusViewModel(
            poolID: 1,
            apiClient: mockNetworkManager
        )

        await poolStatusViewModel.fetch()

        #expect(poolStatusViewModel.skimDate == "")
        #expect(poolStatusViewModel.vacuumDate == "")
        #expect(poolStatusViewModel.brushDate == "")
        #expect(poolStatusViewModel.emptyBasketsDate == "")
        #expect(poolStatusViewModel.testWaterDate == "")
        #expect(poolStatusViewModel.cleanFilterDate == "")
        #expect(poolStatusViewModel.runPumpDate == "")
        #expect(poolStatusViewModel.inspectDate == "")
    }
}
