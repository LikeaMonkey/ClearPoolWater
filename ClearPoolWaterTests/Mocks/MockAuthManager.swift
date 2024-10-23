//
//  MockAuthManager.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Foundation

@testable import ClearPoolWater

@Observable
final class MockAuthManager: AuthManaging {
    var accessToken: String? { userToken?.value }
    var userId: Int? { userToken?.user }

    private var userToken: UserToken?

    init(userToken: UserToken? = nil) {
        self.userToken = userToken
    }

    func login(with userToken: UserToken) {
        self.userToken = userToken
    }

    func logout() {
        userToken = nil
    }
}
