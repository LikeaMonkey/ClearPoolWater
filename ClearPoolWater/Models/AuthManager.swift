//
//  AuthManager.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import Combine
import Foundation
import JWTDecode

@MainActor @Observable
final class AuthManager: AuthManaging {
    static let shared = AuthManager()

    var isLoggedIn = false

    var token: String? {
        get { tokenSubject.value }
        set { tokenSubject.send(newValue) }
    }

    var userId: Int? { internalUserId }
    var isAdmin: Bool? { internalIsAdmin }

    var tokenPublisher: AnyPublisher<String?, Never> {
        tokenSubject.eraseToAnyPublisher()
    }

    private var userToken: UserToken?
    private var internalUserId: Int?
    private var internalIsAdmin: Bool?

    private var tokenSubject = CurrentValueSubject<String?, Never>(nil)

    private init() {
        Task {
            if let savedToken = await loadTokenFromKeychain() {
                await login(with: savedToken, isFromKeychain: true)
            }
        }
    }

    func login(with token: String) async {
        await login(with: token, isFromKeychain: false)
    }

    private func login(with token: String, isFromKeychain: Bool) async {
        do {
            let jwt = try JWTDecode.decode(jwt: token)
            if let userId = jwt["userId"].integer {
                internalUserId = userId
            }
            if let admin = jwt["admin"].boolean {
                internalIsAdmin = admin
            }
        } catch {
            assertionFailure("Failed to decode JWT: \(error)")
        }

        self.token = token

        if !isFromKeychain {
            await saveTokenToKeychain(token)
        }

        isLoggedIn = true
    }

    func logout() async {
        internalUserId = nil
        internalIsAdmin = nil

        userToken = nil

        await deleteTokenFromKeychain()

        isLoggedIn = false
    }

    // MARK: Keychain Support

    private func saveTokenToKeychain(_ token: String) async {
        do {
            try await KeychainManager.shared.saveToken(token, forKey: KeychainKeys.token)
        } catch {
            assertionFailure("Failed to save token to keychain: \(error)")
        }
    }

    private func loadTokenFromKeychain() async -> String? {
        await KeychainManager.shared.getToken(forKey: KeychainKeys.token)
    }

    private func deleteTokenFromKeychain() async {
        do {
            try await KeychainManager.shared.deleteToken(forKey: KeychainKeys.token)
        } catch {
            assertionFailure("Failed to delete token from keychain: \(error)")
        }
    }
}
