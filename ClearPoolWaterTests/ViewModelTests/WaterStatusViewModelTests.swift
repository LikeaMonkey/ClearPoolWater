//
//  WaterStatusViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Testing

@testable import ClearPoolWater

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

        #expect(model.ph == "7,2")
        #expect(model.chlorine == "1,1")
        #expect(model.alkalinity == "80")
        #expect(model.temperature == "28")
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

        #expect(model.alkalinity.isEmpty)
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

        #expect(model.temperature.isEmpty)
    }

    @Test
    func testSaveSuccess() async throws {
        let apiManager = MockAPIManager()
        apiManager.result = WaterStatus(
            id: 1,
            ph: 7.2,
            chlorine: 1.1,
            alkalinity: 80,
            temperature: nil
        )

        let model = WaterStatusViewModel(poolId: 1, apiClient: apiManager)

        await model.fetchWaterStatus()

        apiManager.result = WaterStatus(
            id: 1,
            ph: 7.5,
            chlorine: 0.8,
            alkalinity: 90,
            temperature: 30
        )

        model.ph = "7.5"
        model.chlorine = "0.8"
        model.alkalinity = "90"
        model.temperature = "30"

        await model.updateWaterStatus()

        #expect(model.ph == "7,5")
        #expect(model.chlorine == "0,8")
        #expect(model.alkalinity == "90")
        #expect(model.temperature == "30")
    }

    @Test
    func testSaveFailWithUnexpectedError() async throws {
        let apiManager = MockAPIManager()
        apiManager.result = WaterStatus(
            id: 1,
            ph: 7.2,
            chlorine: 1.1,
            alkalinity: 80,
            temperature: nil
        )

        let model = WaterStatusViewModel(poolId: 1, apiClient: apiManager)

        await model.fetchWaterStatus()

        apiManager.error = APIError.invalidResponse

        model.ph = "7.5"
        model.chlorine = "0.8"
        model.alkalinity = "90"
        model.temperature = "30"

        await model.updateWaterStatus()

        #expect(model.errorMessage == "Unexpected Error!")
    }
}