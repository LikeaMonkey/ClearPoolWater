//
//  LoginViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Testing

@testable import ClearPoolWater

struct LoginViewModelTests {
    @Test
    func testLoginSuccess() async throws {
        let token = "testToken"

        let mockAuthManager = MockAuthManager(isLoggedIn: false)
        let model = LoginViewModel(
            authManager: mockAuthManager,
            apiClient: MockAPIManager(result: UserToken(token: token))
        )

        await model.login()

        #expect(mockAuthManager.token == token)
        #expect(mockAuthManager.userId != nil)

        #expect(model.errorMessage == nil)
    }

    @Test
    func testLoginFailWithBadStatus() async throws {
        let badStatusCode = 400

        let mockAuthManager = MockAuthManager(isLoggedIn: false)
        let model = LoginViewModel(
            authManager: mockAuthManager,
            apiClient: MockAPIManager(error: APIError.badStatusCode(badStatusCode))
        )

        await model.login()

        #expect(mockAuthManager.token == nil)
        #expect(mockAuthManager.userId == nil)

        let expectedErrorMessage = "Bad status code \(badStatusCode)!"
        #expect(model.errorMessage == expectedErrorMessage)
    }

    @Test
    func testLoginFailWithUnexpectedError() async throws {
        let mockAuthManager = MockAuthManager(isLoggedIn: false)
        let model = LoginViewModel(
            authManager: mockAuthManager,
            apiClient: MockAPIManager(error: APIError.invalidResponse)
        )

        await model.login()

        #expect(mockAuthManager.token == nil)
        #expect(mockAuthManager.userId == nil)

        let expectedErrorMessage = "Unexpected error!"
        #expect(model.errorMessage == expectedErrorMessage)
    }
}
