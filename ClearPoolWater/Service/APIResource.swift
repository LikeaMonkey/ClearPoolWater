//
//  APIResource.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

import Foundation

protocol APIResource: Sendable {
    associatedtype ModelType: Codable

    var path: String { get }
    var id: Int? { get }

    var method: HTTPMethod { get }
    var body: ModelType? { get }
    var headers: [String: String]? { get }
}

extension APIResource {
    var id: Int? { nil }

    var method: HTTPMethod { .get }
    var body: ModelType? { nil }
    var headers: [String: String]? { nil }

    var url: URL {
        var url = URL(string: Configuration.baseURL)!
        url.append(path: path)

        if let id {
            url.append(path: "/\(id)")
        }

        return url
    }
}
