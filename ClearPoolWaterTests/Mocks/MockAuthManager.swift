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
final class MockAuthManager: AuthManaging, @unchecked Sendable {
    @MainActor var isLoggedIn = false

    var token: String? {
        get { tokenSubject.value }
        set { tokenSubject.send(newValue) }
    }

    var tokenPublisher: AnyPublisher<String?, Never> {
        tokenSubject.eraseToAnyPublisher()
    }

    private let tokenSubject = CurrentValueSubject<String?, Never>(nil)

    init(isLoggedIn: Bool = true) {
        if isLoggedIn {
            login(with: "testToken")
        }
    }

    func login(with token: String) {
        self.token = token
        Task { @MainActor in
            isLoggedIn = true
        }
    }

    func logout() {
        token = nil
        Task { @MainActor in
            isLoggedIn = false
        }
    }
}
