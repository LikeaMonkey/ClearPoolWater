//
//  CreatePoolViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Testing

@testable import ClearPoolWater

struct CreatePoolViewModelTests {
    @Test
    func testAddNewPoolSuccess() async throws {
        let pool = Pool(
            id: 1,
            name: "testPoolName",
            waterLevel: 80,
            waterCapacity: 5,
            filterType: .sand
        )
        let userToken = UserToken(value: "testTokenValue", user: 1)
        let mockAuthManager = MockAuthManager(userToken: userToken)
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = pool

        let createPoolViewModel = CreatePoolViewModel(
            authManager: mockAuthManager,
            apiClient: mockNetworkManager
        )
        createPoolViewModel.name = pool.name

        await createPoolViewModel.addNewPool()

        #expect(createPoolViewModel.name == pool.name)
    }
}
