//
//  Model.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import OSLog
import SwiftUI

enum AccessError: Error {
    case noToken
}

@Observable
class Model {
    private(set) var user: User?

    private let logger = Logger(subsystem: "com.clear.pool.water.model", category: "Model")

    func fetchData() async {
        guard let accessToken = AuthManager.shared.accessToken else {
            // TODO: Add error message
            logger.debug("Refuse access. User is not authenticated")
            return
        }

        let requestBuilder = RequestBuilder(protectedBy: accessToken)
        let networkManager = NetworkManager(requestBuilder: requestBuilder)
        let url = URLProvider().meURL
        do {
            user = try await networkManager.get(url: url)
            logger.info("Fetch user data successfully")
        } catch {
            logger.error(
                "Fetch user data failed with an unexpected error: \(error.localizedDescription, privacy: .public)"
            )
        }
    }
}
