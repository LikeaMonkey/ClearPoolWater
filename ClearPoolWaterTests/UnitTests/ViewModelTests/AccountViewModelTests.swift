//
//  AccountViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import Testing

@testable import ClearPoolWater

@MainActor
struct AccountViewModelTests {
    @Test
    func testFetchSuccess() async throws {
        let user = User(id: 1, email: "test@test.com", role: .user)
        let model = AccountViewModel(apiClient: MockAPIManager(result: user))

        await model.fetchAccount()

        #expect(model.state == .success)
        #expect(model.user == user)
    }

    @Test
    func testFetchFail() async throws {
        let error = APIError.invalidResponse
        let model = AccountViewModel(apiClient: MockAPIManager(error: error))

        await model.fetchAccount()

        #expect(model.state == .failure)
        #expect(model.user == nil)
    }
}
