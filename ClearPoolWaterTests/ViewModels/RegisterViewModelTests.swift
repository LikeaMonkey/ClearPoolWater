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
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.resultToReturn = user

        let registerViewModel = RegisterViewModel(
            apiClient: mockNetworkManager
        )

        await registerViewModel.register()

        #expect(registerViewModel.success == true)
        #expect(registerViewModel.errorMessage == nil)
    }

    @Test
    func testRegisterFailedWithBadStatusCode() async throws {
        let code = 400
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.errorToThrow = NetworkError.badStatusCode(code)

        let registerViewModel = RegisterViewModel(
            apiClient: mockNetworkManager
        )

        await registerViewModel.register()

        #expect(registerViewModel.success == false)
        #expect(registerViewModel.errorMessage == "Bad status code \(code)!")
    }

    @Test
    func testRegisterFailedWithUnexpectedError() async throws {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.errorToThrow = NetworkError.invalidResponse

        let registerViewModel = RegisterViewModel(
            apiClient: mockNetworkManager
        )

        await registerViewModel.register()

        #expect(registerViewModel.success == false)
        #expect(registerViewModel.errorMessage == "Unexpected Error!")
    }
}
