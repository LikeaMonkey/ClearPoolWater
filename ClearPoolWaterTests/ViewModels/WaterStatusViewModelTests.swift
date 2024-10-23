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
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = waterStatus

        let waterStatusViewModel = WaterStatusViewModel(
            poolID: 1,
            apiClient: mockNetworkManager
        )

        await waterStatusViewModel.fetch()

        #expect(waterStatusViewModel.ph == "7,2")
        #expect(waterStatusViewModel.chlorine == "1,1")
        #expect(waterStatusViewModel.alkalinity == "80")
        #expect(waterStatusViewModel.temperature == "28")
    }

    @Test
    func testFetchFailedWithUnexpectedError() async throws {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.errorToThrow = NetworkError.invalidResponse

        let waterStatusViewModel = WaterStatusViewModel(
            poolID: 1,
            apiClient: mockNetworkManager
        )

        await waterStatusViewModel.fetch()

        #expect(waterStatusViewModel.errorMessage == "Unexpected Error!")
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
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = waterStatus

        let waterStatusViewModel = WaterStatusViewModel(
            poolID: 1,
            apiClient: mockNetworkManager
        )

        await waterStatusViewModel.fetch()

        #expect(waterStatusViewModel.alkalinity == "")
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
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = waterStatus

        let waterStatusViewModel = WaterStatusViewModel(
            poolID: 1,
            apiClient: mockNetworkManager
        )

        await waterStatusViewModel.fetch()

        #expect(waterStatusViewModel.temperature == "")
    }

    @Test
    func testSaveSuccess() async throws {
        let waterStatus = WaterStatus(
            id: 1,
            ph: 7.2,
            chlorine: 1.1,
            alkalinity: 80,
            temperature: nil
        )
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = waterStatus

        let waterStatusViewModel = WaterStatusViewModel(
            poolID: 1,
            apiClient: mockNetworkManager
        )

        await waterStatusViewModel.fetch()

        let updatedWaterStatus = WaterStatus(
            id: 1,
            ph: 7.5,
            chlorine: 0.8,
            alkalinity: 90,
            temperature: 30
        )
        mockNetworkManager.resultToReturn = updatedWaterStatus

        waterStatusViewModel.ph = "7.5"
        waterStatusViewModel.chlorine = "0.8"
        waterStatusViewModel.alkalinity = "90"
        waterStatusViewModel.temperature = "30"

        await waterStatusViewModel.save()

        #expect(waterStatusViewModel.ph == "7,5")
        #expect(waterStatusViewModel.chlorine == "0,8")
        #expect(waterStatusViewModel.alkalinity == "90")
        #expect(waterStatusViewModel.temperature == "30")
    }

    @Test
    func testSaveFailWithUnexpectedError() async throws {
        let waterStatus = WaterStatus(
            id: 1,
            ph: 7.2,
            chlorine: 1.1,
            alkalinity: 80,
            temperature: nil
        )
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = waterStatus

        let waterStatusViewModel = WaterStatusViewModel(
            poolID: 1,
            apiClient: mockNetworkManager
        )

        await waterStatusViewModel.fetch()

        mockNetworkManager.errorToThrow = NetworkError.invalidResponse

        waterStatusViewModel.ph = "7.5"
        waterStatusViewModel.chlorine = "0.8"
        waterStatusViewModel.alkalinity = "90"
        waterStatusViewModel.temperature = "30"

        await waterStatusViewModel.save()

        #expect(waterStatusViewModel.errorMessage == "Unexpected Error!")
    }
}
