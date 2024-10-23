//
//  APIClient.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import Foundation

protocol APIClient {
    func get<T: Decodable>(url: URL, headers: [String: String]?) async throws -> T

    func post<T: Decodable>(url: URL, headers: [String: String]?) async throws -> T
    func post<T: Decodable, U: Encodable>(
        url: URL,
        body: U,
        headers: [String: String]?
    ) async throws -> T

    func put<T: Decodable>(url: URL, headers: [String: String]?) async throws -> T
    func put<T: Decodable, U: Encodable>(
        url: URL,
        body: U,
        headers: [String: String]?
    ) async throws -> T
}
