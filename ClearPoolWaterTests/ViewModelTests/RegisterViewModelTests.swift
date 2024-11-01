//
//  RegisterViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 23.10.24.
//

import Testing

@testable import ClearPoolWater

struct RegisterViewModelTests {
    @Test
    func testRegisterSuccess() async throws {
        let user = User(id: 1, email: "test@test.com", role: .user)
        let model = RegisterViewModel(
            apiClient: MockAPIManager(result: user)
        )

        await model.register()

        #expect(model.success)
        #expect(model.errorMessage == nil)
    }

    @Test
    func testRegisterFailedWithBadStatusCode() async throws {
        let code = 300
        let model = RegisterViewModel(
            apiClient: MockAPIManager(error: APIError.badStatusCode(code))
        )

        await model.register()

        #expect(!model.success)
        #expect(model.errorMessage == "Bad status code \(code)!")
    }

    @Test
    func testRegisterFailedWithUnexpectedError() async throws {
        let model = RegisterViewModel(
            apiClient: MockAPIManager(error: APIError.invalidResponse)
        )

        await model.register()

        #expect(!model.success)
        #expect(model.errorMessage == "Unexpected Error!")
    }
}
