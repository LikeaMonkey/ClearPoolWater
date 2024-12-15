//
//  WaterStatusViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Testing

@testable import ClearPoolWater

@MainActor
struct WaterStatusViewModelTests {
    @Test
    func testFetchSuccess() async throws {
        let waterStatus = WaterStatus(
            id: 1,
            ph: 7.2,
            chlorine: 1.1,
            alkalinity: 80,
            temperature: 28
        )
        let model = WaterStatusViewModel(
            poolId: 1,
            apiClient: MockAPIManager(result: waterStatus)
        )

        await model.fetchWaterStatus()

        #expect(model.ph == 7.2)
        #expect(model.chlorine == 1.1)
        #expect(model.alkalinity == 80)
        #expect(model.temperature == 28)
    }

    @Test
    func testFetchFailedWithUnexpectedError() async throws {
        let model = WaterStatusViewModel(
            poolId: 1,
            apiClient: MockAPIManager(error: APIError.invalidResponse)
        )

        await model.fetchWaterStatus()

        #expect(model.errorMessage == "Unexpected Error!")
    }

    @Test
    func testFetchWithNoAlkalinity() async throws {
        let waterStatus = WaterStatus(
            id: 1,
            ph: 7.2,
            chlorine: 1.1,
            alkalinity: nil,
            temperature: 28
        )
        let model = WaterStatusViewModel(
            poolId: 1,
            apiClient: MockAPIManager(result: waterStatus)
        )

        await model.fetchWaterStatus()

        #expect(model.alkalinity == nil)
    }

    @Test
    func testFetchWithNoTemperature() async throws {
        let waterStatus = WaterStatus(
            id: 1,
            ph: 7.2,
            chlorine: 1.1,
            alkalinity: 80,
            temperature: nil
        )
        let model = WaterStatusViewModel(
            poolId: 1,
            apiClient: MockAPIManager(result: waterStatus)
        )

        await model.fetchWaterStatus()

        #expect(model.temperature == nil)
    }
}
