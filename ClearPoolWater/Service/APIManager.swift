//
//  APIManager.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

import Foundation

protocol APIClient {
    func execute<R: APIResource, T: Decodable>(with resource: R) async throws -> T
}

final class APIManager: APIClient {
    private let urlCache: URLCache
    private let urlRequestBuilder: URLRequestBuilding

    init(
        urlCache: URLCache = .shared,
        urlRequestBuilder: URLRequestBuilding = URLRequestBuilder(
            tokenPublisher: AuthManager.shared.tokenPublisher
        )
    ) {
        self.urlCache = urlCache
        self.urlRequestBuilder = urlRequestBuilder
    }

    func execute<R: APIResource, T: Decodable>(with resource: R) async throws -> T {
        if resource.method == .get, let cachedData = getCachedData(for: resource.url) {
            let decodedData: T = try decodeData(cachedData)
            return decodedData
        }

        let request = try urlRequestBuilder.build(for: resource)
        let (data, response) = try await execute(request: request)

        let decodedData: T = try decodeData(data)

        cache(response, data: data, for: resource.url)

        return decodedData
    }

    private func execute(request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            guard httpResponse.statusCode == 200 else {
                switch httpResponse.statusCode {
                case 400..<500:
                    throw APIError.client(httpResponse.statusCode)
                case 500..<600:
                    throw APIError.server(httpResponse.statusCode)
                default:
                    throw APIError.badStatusCode(httpResponse.statusCode)
                }
            }

            return (data, response)
        } catch {
            throw APIError.transportError(error)
        }
    }

    private var urlSession: URLSession {
        URLSession(
            configuration: .default,
            delegate: SSLPinningDelegate(),
            delegateQueue: nil
        )
    }

    private func decodeData<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decodedData = try JSONDecoder.apiDecoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIError.decodingFailed(error)
        }
    }

    private func getCachedData(for url: URL) -> Data? {
        let request = URLRequest(url: url)
        let cachedResponse = urlCache.cachedResponse(for: request)
        return cachedResponse?.data
    }

    private func cache(_ response: URLResponse, data: Data, for url: URL) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        let request = URLRequest(url: url)
        urlCache.storeCachedResponse(cachedResponse, for: request)
    }
}
