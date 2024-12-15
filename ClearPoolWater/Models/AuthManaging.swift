//
//  AuthManaging.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Combine

protocol AuthManaging: Sendable {
    @MainActor var isLoggedIn: Bool { get set }

    var token: String? { get set }
    var userId: Int? { get }
    var isAdmin: Bool? { get }

    var tokenPublisher: AnyPublisher<String?, Never> { get }  // Add publisher for the token

    func login(with token: String) async
    func logout() async
}
