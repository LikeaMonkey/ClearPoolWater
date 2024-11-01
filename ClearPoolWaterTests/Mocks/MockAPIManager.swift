//
//  MockAPIManager.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import Foundation

@testable import ClearPoolWater

final class MockAPIManager: APIClient {
    var result: Any?
    var error: Error?

    init(result: Any? = nil, error: Error? = nil) {
        self.result = result
        self.error = error
    }

    func execute<R: APIResource, T: Decodable>(with resource: R) async throws -> T {
        if let error {
            throw error
        }
        return result as! T
    }
}
