//
//  APIUtils.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

import Foundation

struct APIUtils {
    static func basicAuthHeaders(email: String, password: String) -> [String: String] {
        let basic = createBasicAuth(email: email, password: password)
        return ["Authorization": basic]
    }

    static func createBasicAuth(email: String, password: String) -> String {
        let loginString = String(format: "%@:%@", email, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        return "Basic \(base64LoginString)"
    }

    static func jwtBearerHeaders(with token: String) -> [String: String] {
        ["Authorization": "Bearer \(token)"]
    }
}
