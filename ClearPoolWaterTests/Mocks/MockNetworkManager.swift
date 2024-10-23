//
//  MockNetworkManager.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Foundation

@testable import ClearPoolWater

final class MockNetworkManager: APIClient {
    var resultToReturn: Any?
    var errorToThrow: Error?

    func get<T: Decodable>(url: URL, headers: [String: String]?) async throws -> T {
        if let error = errorToThrow {
            throw error
        }
        return resultToReturn as! T
    }

    func post<T: Decodable>(url: URL, headers: [String: String]?) async throws -> T {
        if let error = errorToThrow {
            throw error
        }
        return resultToReturn as! T
    }

    func post<T: Decodable, U: Encodable>(
        url: URL,
        body: U,
        headers: [String: String]?
    ) async throws -> T {
        if let error = errorToThrow {
            throw error
        }
        return resultToReturn as! T
    }

    func put<T: Decodable>(url: URL, headers: [String: String]?) async throws -> T {
        if let error = errorToThrow {
            throw error
        }
        return resultToReturn as! T
    }

    func put<T: Decodable, U: Encodable>(
        url: URL,
        body: U,
        headers: [String: String]?
    ) async throws -> T {
        if let error = errorToThrow {
            throw error
        }
        return resultToReturn as! T
    }
}
