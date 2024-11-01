//
//  APIError.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

enum APIError: Error {
    /// Represents non-HTTP or unexpected response errors
    case invalidResponse

    /// Represents HTTP response 4xx status code
    case client(Int)

    /// Represents HTTP response 5xx status code
    case server(Int)

    /// Specific case for non-2xx, non-4xx and non 5xx status codes
    case badStatusCode(Int)

    /// Failed to decode the response body
    case decodingFailed(Error)

    /// Represents underlying network transport errors
    case transportError(Error)
}
