//
//  NetworkManager.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse  // For non-HTTP responses or unexpected responses
    case badStatusCode(Int)  // A specific case for non-2xx status codes
    case decodingFailed(Error)  // Failed to decode the response body
    case transportError(Error)  // Represents underlying network transport errors
}

class NetworkManager: APIClient {
    private let urlCache: URLCache
    private let requestBuilder: RequestBuilding

    init(
        urlCache: URLCache = .shared,
        requestBuilder: RequestBuilding = RequestBuilder()
    ) {
        self.urlCache = urlCache
        self.requestBuilder = requestBuilder
    }

    func get<T: Decodable>(url: URL, headers: [String: String]? = nil) async throws -> T {
        //        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url)) {
        //            return try decodeData(cachedResponse.data)
        //        }

        let request = try requestBuilder.buildRequest(for: url, method: "GET", headers: headers)
        let (data, response) = try await fetchData(for: request)

        cacheResponse(response, data: data, for: URLRequest(url: url))

        return try decodeData(data)
    }

    private func cacheResponse(_ response: URLResponse, data: Data, for request: URLRequest) {
        // let cachedResponse = CachedURLResponse(response: response, data: data)
        // urlCache.storeCachedResponse(cachedResponse, for: request)
    }

    func post<T: Decodable, U: Encodable>(
        url: URL,
        body: U,
        headers: [String: String]? = nil
    ) async throws -> T {
        let request = try requestBuilder.buildRequest(
            for: url,
            method: "POST",
            body: body,
            headers: headers
        )
        let (data, _) = try await fetchData(for: request)

        return try decodeData(data)
    }

    func post<T: Decodable>(
        url: URL,
        headers: [String: String]? = nil
    ) async throws -> T {
        let request = try requestBuilder.buildRequest(for: url, method: "POST", headers: headers)
        let (data, _) = try await fetchData(for: request)

        return try decodeData(data)
    }

    func put<T: Decodable>(url: URL, headers: [String: String]?) async throws -> T {
        let request = try requestBuilder.buildRequest(for: url, method: "PUT", headers: headers)
        let (data, _) = try await fetchData(for: request)

        return try decodeData(data)
    }

    func put<T: Decodable, U: Encodable>(
        url: URL,
        body: U,
        headers: [String: String]?
    ) async throws -> T {
        let request = try requestBuilder.buildRequest(
            for: url,
            method: "PUT",
            body: body,
            headers: headers
        )
        let (data, _) = try await fetchData(for: request)

        return try decodeData(data)
    }

    private func fetchData(for request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            guard httpResponse.statusCode == 200 else {
                throw NetworkError.badStatusCode(httpResponse.statusCode)
            }

            return (data, response)
        } catch {
            throw NetworkError.transportError(error)
        }
    }

    private func decodeData<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    private var session: URLSession {
        URLSession(
            configuration: .default,
            delegate: SSLPinningDelegate(),
            delegateQueue: nil
        )
    }
}
