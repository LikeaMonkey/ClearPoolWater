//
//  URLProvider.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import Foundation

struct URLProvider: URLProviding {
    var loginURL: URL { URL(string: "\(Configuration.baseURL)/login")! }
    var registerURL: URL { URL(string: "\(Configuration.baseURL)/api/users")! }
    var meURL: URL { URL(string: "\(Configuration.baseURL)/me")! }

    var poolsURL: URL { URL(string: "\(Configuration.baseURL)/api/pools")! }
    func poolsURL(poolId: Int) -> URL {
        poolsURL.appendingPathComponent("\(poolId)")
    }
    func poolsURL(userId: Int) -> URL {
        poolsURL.appendingPathComponent("user/\(userId)")
    }

    var poolStatusURL: URL { URL(string: "\(Configuration.baseURL)/api/poolStatus")! }
    func poolStatusURL(poolStatusId: Int) -> URL {
        poolStatusURL.appendingPathComponent("\(poolStatusId)")
    }
    func poolStatusURL(poolId: Int) -> URL {
        poolStatusURL.appendingPathComponent("pool/\(poolId)")
    }

    var waterStatusURL: URL { URL(string: "\(Configuration.baseURL)/api/waterStatus")! }
    func waterStatusURL(waterStatusId: Int) -> URL {
        waterStatusURL.appendingPathComponent("\(waterStatusId)")
    }
    func waterStatusURL(poolId: Int) -> URL {
        waterStatusURL.appendingPathComponent("pool/\(poolId)")
    }
}
