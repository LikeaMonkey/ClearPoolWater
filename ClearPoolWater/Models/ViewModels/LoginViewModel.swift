//
//  LoginViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import AuthenticationServices
import OSLog
import SwiftUI

@Observable
final class LoginViewModel {
    var email = ""
    var password = ""

    private(set) var isLoading = false
    private(set) var errorMessage: String?

    private let logger = Logger(subsystem: "com.clear.pool.water.login", category: "LoginViewModel")

    private let authManager: AuthManaging
    private let apiClient: APIClient
    private let urlProvider: URLProviding

    init(
        authManager: AuthManaging = AuthManager.shared,
        apiClient: APIClient = NetworkManager(),
        urlProvider: URLProviding = URLProvider()
    ) {
        self.authManager = authManager
        self.apiClient = apiClient
        self.urlProvider = urlProvider
    }

    func login() async {
        isLoading = true

        do {
            try await sendLoginRequest()
        } catch {
            switch error {
            case NetworkError.badStatusCode(let code):
                errorMessage = "Bad status code \(code)!"
                logger.error("Login failed with bad status code: \(code)")
            default:
                errorMessage = "Unexpected error!"
                logger.error(
                    "Registration failed with an unexpected error: \(error.localizedDescription, privacy: .public)"
                )
            }
        }

        isLoading = false
    }

    private func sendLoginRequest() async throws {
        let url = urlProvider.loginURL
        let headers = ["Authorization": createBasicAuthentication()]
        let userToken: UserToken = try await apiClient.post(url: url, headers: headers)

        authManager.login(with: userToken)

        logger.info("Login successful")
    }

    private func createBasicAuthentication() -> String {
        let loginString = String(format: "%@:%@", email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        return "Basic \(base64LoginString)"
    }

    func handleSignInWithApple(_ result: Result<ASAuthorization, any Error>) {
        switch result {
        case .success(let authResults):
            logger.info("Authorization successful")
            handleAuthorization(authResults)
        case .failure(let error):
            logger.error("Authorization failed: \(error.localizedDescription)")
        }
    }

    private func handleAuthorization(_ authorization: ASAuthorization) {
        // TODO: Add server support for Sign in with Apple

        //        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
        //              let identityToken = credential.identityToken,
        //              let identityTokenString = String(data: identityToken, encoding: .utf8)
        //        else {
        //            return
        //        }

        // let body = ["appleIdentityToken": identityTokenString]
        // guard let jsonData = try? JSONEncoder().encode(body) else { return }
        //
        // Fire an API request to your server to authenticate with the identity
        // token attached in the request headers
    }
}
