//
//  RequestBuilder.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import Foundation

protocol RequestBuilding {
    func buildRequest<T: Encodable>(
        for url: URL,
        method: String,
        body: T?,
        headers: [String: String]?
    ) throws -> URLRequest

    func buildRequest(
        for url: URL,
        method: String,
        headers: [String: String]?
    ) throws -> URLRequest
}

class RequestBuilder: RequestBuilding {
    private let accessToken: String?

    init(protectedBy accessToken: String? = nil) {
        self.accessToken = AuthManager.shared.accessToken
    }

    func buildRequest<T: Encodable>(
        for url: URL,
        method: String,
        body: T,
        headers: [String: String]?
    ) throws -> URLRequest {
        var request = try buildRequest(for: url, method: method, headers: headers)

        request.httpBody = try JSONEncoder().encode(body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }

    func buildRequest(
        for url: URL,
        method: String,
        headers: [String: String]?
    ) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method

        // Add authorization header if available
        if let token = accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        // Add any additional headers
        headers?
            .forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }

        return request
    }
}
