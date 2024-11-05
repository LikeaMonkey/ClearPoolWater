//
//  AccountViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import OSLog
import SwiftUI

@Observable
final class AccountViewModel {
    var user: User?

    private(set) var isLoading = false
    private(set) var errorMessage: String?

    private let logger = Logger(
        subsystem: "com.clear.pool.water.account",
        category: "AccountViewModel"
    )

    private let authManager: AuthManaging
    private let apiClient: APIClient

    init(
        authManager: AuthManaging = AuthManager.shared,
        apiClient: APIClient = APIManager()
    ) {
        self.authManager = authManager
        self.apiClient = apiClient
    }

    func fetchAccount() async {
        isLoading = true
        defer { isLoading = false }

        do {
            user = try await apiClient.execute(with: MeResource())
        } catch {
            switch error {
            case APIError.badStatusCode(let code):
                errorMessage = "Bad status code \(code)!"
                logger.error("Account fetching failed with bad status code: \(code)")
            default:
                errorMessage = "Unexpected error!"
                logger.error(
                    "Account fetching failed with an unexpected error: \(error.localizedDescription)"
                )
            }
        }
    }
}
