//
//  AuthManaging.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Combine

protocol AuthManaging: Sendable {
    @MainActor var isLoggedIn: Bool { get }
    var token: String? { get }
    var tokenPublisher: AnyPublisher<String?, Never> { get }  // Add publisher for the token

    func login(with token: String)
    func logout()
}
