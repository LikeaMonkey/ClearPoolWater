//
//  URLSessionDelegateMultiplexer.swift
//  Test - Test 1
//
//  Created by Stanimir Hristov on 9.10.24.
//

import Foundation

final class URLSessionDelegateMultiplexer: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    private let sslDelegate: SSLPinningDelegate
    private let metricsDelegate: MetricsSessionDelegate

    init(sslDelegate: SSLPinningDelegate, metricsDelegate: MetricsSessionDelegate) {
        self.sslDelegate = sslDelegate
        self.metricsDelegate = metricsDelegate
    }

    // Forwarding ssl related delegate methods
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge
    ) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        await sslDelegate.urlSession(session, didReceive: challenge)
    }

    // Forwarding metrics-related delegate methods
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didFinishCollecting metrics: URLSessionTaskMetrics
    ) {
        metricsDelegate.urlSession(session, task: task, didFinishCollecting: metrics)
    }
}
