//
//  AccountViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import OSLog
import SwiftUI

@MainActor @Observable
final class AccountViewModel {
    var user: User?

    private(set) var state = ViewState.loading

    private let apiClient: APIClient
    private let logger = Logger(
        subsystem: "com.clear.pool.water.account",
        category: "AccountViewModel"
    )

    init(apiClient: APIClient = APIManager()) {
        self.apiClient = apiClient
    }

    func fetchAccount() async {
        state = .loading

        do {
            user = try await apiClient.execute(with: MeResource())

            state = .success

            logger.info("Account fetched successfully")
        } catch {
            state = .failure

            logger.error("Account fetching failed with error: \(error.localizedDescription)")
        }
    }
}
