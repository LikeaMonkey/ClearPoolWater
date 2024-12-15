//
//  CreatePoolViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Testing

@testable import ClearPoolWater

@MainActor
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
        let model = CreatePoolViewModel(
            authManager: MockAuthManager(),
            apiClient: MockAPIManager(result: pool)
        )
        model.name = pool.name

        await model.addNewPool()

        #expect(model.name == pool.name)
    }
}
