//
//  RegisterViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import OSLog
import SwiftUI

@Observable
final class RegisterViewModel {
    var email = ""
    var password = ""
    var confirmPassword = ""

    private(set) var isLoading = false
    private(set) var errorMessage: String?
    private(set) var success = false

    private let apiClient: APIClient
    private let urlProvider: URLProviding

    private let logger = Logger(
        subsystem: "com.clear.pool.water.register",
        category: "RegisterViewModel"
    )

    init(
        apiClient: APIClient = NetworkManager(),
        urlProvider: URLProviding = URLProvider()
    ) {
        self.apiClient = apiClient
        self.urlProvider = urlProvider
    }

    func register() async {
        isLoading = true

        do {
            try await sendRegisterRequest()
            success = true
        } catch {
            switch error {
            case NetworkError.badStatusCode(let code):
                errorMessage = "Bad status code \(code)!"
                logger.error("Registration failed with bad status code: \(code)")
            default:
                errorMessage = "Unexpected Error!"
                logger.error(
                    "Registration failed with an unexpected error: \(error.localizedDescription, privacy: .public)"
                )
            }
        }

        isLoading = false
    }

    private func sendRegisterRequest() async throws {
        let url = urlProvider.registerURL
        let userCreate = User.Create(
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            role: .user
        )

        let user: User = try await apiClient.post(url: url, body: userCreate, headers: nil)
        logger.info("Register user successfully: \(user.email, privacy: .private)")
    }
}
