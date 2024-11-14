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
        let model = PoolsViewModel(apiClient: MockAPIManager(result: pools))

        await model.fetchPools()

        #expect(model.state == .success)
        #expect(model.pools == pools)
    }

    @Test
    func testFetchFail() async throws {
        let error = APIError.invalidResponse
        let model = PoolsViewModel(apiClient: MockAPIManager(error: error))

        await model.fetchPools()

        #expect(model.state == .failure)
        #expect(model.pools.isEmpty)
    }
}
