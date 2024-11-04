//
//  PoolsViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Testing

@testable import ClearPoolWater

struct PoolsViewModelTests {
    @Test
    func testFetchSuccess() async throws {
        let pools = [Pool.example]
        let model = PoolsViewModel(
            authManager: MockAuthManager(),
            apiClient: MockAPIManager(result: pools)
        )

        await model.fetchPools()

        #expect(model.pools == pools)
    }

    @Test
    func testFetchFailWithUserNotLoggedIn() async throws {
        let model = PoolsViewModel(
            authManager: MockAuthManager(isLoggedIn: false),
            apiClient: MockAPIManager()
        )

        await model.fetchPools()

        #expect(model.pools.isEmpty)
    }

    @Test
    func testFetchFailWithUnexpectedError() async throws {
        let model = PoolsViewModel(
            authManager: MockAuthManager(),
            apiClient: MockAPIManager(error: APIError.invalidResponse)
        )

        await model.fetchPools()

        #expect(model.pools.isEmpty)
    }
}
