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

        let userToken = UserToken(value: "testTokenValue", user: 1)
        let mockAuthManager = MockAuthManager(userToken: userToken)
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = pools

        let poolsViewModel = PoolsViewModel(
            authManager: mockAuthManager,
            apiClient: mockNetworkManager
        )

        await poolsViewModel.fetch()

        #expect(poolsViewModel.pools == pools)
    }

    @Test
    func testFetchFailWithUserNotLoggedIn() async throws {
        let mockAuthManager = MockAuthManager()
        let mockNetworkManager = MockNetworkManager()

        let poolsViewModel = PoolsViewModel(
            authManager: mockAuthManager,
            apiClient: mockNetworkManager
        )

        await poolsViewModel.fetch()

        #expect(poolsViewModel.pools.isEmpty == true)
    }

    @Test
    func testFetchFailWithUnexpectedError() async throws {
        let userToken = UserToken(value: "testTokenValue", user: 1)
        let mockAuthManager = MockAuthManager(userToken: userToken)
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.errorToThrow = NetworkError.invalidResponse

        let poolsViewModel = PoolsViewModel(
            authManager: mockAuthManager,
            apiClient: mockNetworkManager
        )

        await poolsViewModel.fetch()

        #expect(poolsViewModel.pools.isEmpty == true)
    }
}
