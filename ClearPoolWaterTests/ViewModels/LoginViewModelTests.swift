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
        let accessToken = "testTokenValue"
        let userId = 1

        let mockAuthManager = MockAuthManager()
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = UserToken(value: accessToken, user: userId)

        let loginViewModel = LoginViewModel(
            authManager: mockAuthManager,
            apiClient: mockNetworkManager
        )

        await loginViewModel.login()

        #expect(mockAuthManager.accessToken == accessToken)
        #expect(mockAuthManager.userId == userId)

        #expect(loginViewModel.errorMessage == nil)
    }

    @Test
    func testLoginFailWithBadStatus() async throws {
        let badStatusCode = 400

        let mockAuthManager = MockAuthManager()
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.errorToThrow = NetworkError.badStatusCode(badStatusCode)

        let loginViewModel = LoginViewModel(
            authManager: mockAuthManager,
            apiClient: mockNetworkManager
        )

        await loginViewModel.login()

        #expect(mockAuthManager.accessToken == nil)
        #expect(mockAuthManager.userId == nil)

        let expectedErrorMessage = "Bad status code \(badStatusCode)!"
        #expect(loginViewModel.errorMessage == expectedErrorMessage)
    }

    @Test
    func testLoginFailWithUnexpectedError() async throws {
        let mockAuthManager = MockAuthManager()
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.errorToThrow = NetworkError.invalidResponse

        let loginViewModel = LoginViewModel(
            authManager: mockAuthManager,
            apiClient: mockNetworkManager
        )

        await loginViewModel.login()

        #expect(mockAuthManager.accessToken == nil)
        #expect(mockAuthManager.userId == nil)

        let expectedErrorMessage = "Unexpected error!"
        #expect(loginViewModel.errorMessage == expectedErrorMessage)
    }
}
