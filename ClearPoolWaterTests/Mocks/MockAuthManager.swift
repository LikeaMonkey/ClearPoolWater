//
//  MockAuthManager.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Combine
import Foundation

@testable import ClearPoolWater

@Observable
final class MockAuthManager: AuthManaging {
    @MainActor var isLoggedIn = false
    var userId: Int? { internalUserId }
    var isAdmin: Bool? { false }

    var token: String? {
        get { tokenSubject.value }
        set { tokenSubject.send(newValue) }
    }

    var tokenPublisher: AnyPublisher<String?, Never> {
        tokenSubject.eraseToAnyPublisher()
    }

    private var tokenSubject = CurrentValueSubject<String?, Never>(nil)
    private var internalUserId: Int?

    init(isLoggedIn: Bool = true) {
        if isLoggedIn {
            login(with: "testToken")
        }
    }

    func login(with token: String) {
        self.token = token
        internalUserId = 1

        Task { @MainActor in
            isLoggedIn = true
        }
    }

    func logout() {
        token = nil
        internalUserId = nil

        Task { @MainActor in
            isLoggedIn = false
        }
    }
}
