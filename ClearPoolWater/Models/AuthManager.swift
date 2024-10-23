//
//  AuthManager.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import Foundation

@Observable
final class AuthManager: AuthManaging {
    static let shared = AuthManager()

    private(set) var loggedIn = false

    var accessToken: String? { userToken?.value }
    var userId: Int? { userToken?.user }

    private var userToken: UserToken?

    private init() {
        userToken = .init(value: "", user: 1)
    }

    func login(with userToken: UserToken) {
        self.userToken = userToken

        loggedIn = true
    }

    func logout() {
        userToken = nil

        loggedIn = false
    }

    // TODO: Add keychain support
    //    enum KeychainKey: String {
    //        case accessToken
    //        case refreshToken
    //    }
}
