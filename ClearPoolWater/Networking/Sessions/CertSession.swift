//
//  CertSession.swift
//  Test - Test 1
//
//  Created by Stanimir Hristov on 8.10.24.
//

import Foundation

/// Custom URLSessionDelegate for SSL certificate handling
final class SSLPinningDelegate: NSObject, URLSessionDelegate {

    /// Called when session receives a challenge from the server (e.g. SSL challenge)
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge
    ) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            return (.cancelAuthenticationChallenge, nil)
        }

        let credential = URLCredential(trust: serverTrust)

        return (.useCredential, credential)
    }
}
