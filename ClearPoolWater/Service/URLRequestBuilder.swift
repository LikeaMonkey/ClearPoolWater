//
//  URLRequestBuilder.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import Combine
import Foundation

protocol URLRequestBuilding: Sendable {
    func build<Resource: APIResource>(for resource: Resource) throws -> URLRequest
}

final class URLRequestBuilder: URLRequestBuilding, @unchecked Sendable {
    private var token: String?
    private var cancellables = Set<AnyCancellable>()

    init() {}

    init(tokenPublisher: AnyPublisher<String?, Never>) {
        tokenPublisher.sink { [weak self] token in
            self?.token = token
        }
        .store(in: &cancellables)
    }

    func build<Resource: APIResource>(for resource: Resource) throws -> URLRequest {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.rawValue

        if let body = resource.body {
            request.httpBody = try JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        resource.headers?
            .forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }

        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return request
    }
}
