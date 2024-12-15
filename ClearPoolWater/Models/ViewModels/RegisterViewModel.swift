//
//  RegisterViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import OSLog
import SwiftUI

@MainActor @Observable
final class RegisterViewModel {
    var email = ""
    var password = ""
    var confirmPassword = ""

    private(set) var isLoading = false
    private(set) var errorMessage: String?
    private(set) var success = false

    private let apiClient: APIClient

    private let logger = Logger(
        subsystem: "com.clear.pool.water.register",
        category: "RegisterViewModel"
    )

    init(apiClient: APIClient = APIManager(urlRequestBuilder: URLRequestBuilder())) {
        self.apiClient = apiClient
    }

    func register() async {
        isLoading = true
        defer { isLoading = false }

        do {
            try await sendRegisterRequest()
        } catch {
            switch error {
            case APIError.badStatusCode(let code):
                errorMessage = "Bad status code \(code)!"
                logger.error("Registration failed with bad status code: \(code)")
            default:
                errorMessage = "Unexpected Error!"
                logger.error(
                    "Registration failed with an unexpected error: \(error.localizedDescription, privacy: .public)"
                )
            }
        }
    }

    private func sendRegisterRequest() async throws {
        let userCreate = User.Create(
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            role: .user
        )
        let user: User = try await apiClient.execute(
            with: UsersResource(method: .post, body: userCreate)
        )

        success = true

        logger.info("Register user successfully: \(user.email, privacy: .private)")
    }
}
