//
//  URLSession+.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

import Foundation

extension URLSession {
    static var apiSession: URLSession {
        URLSession(
            configuration: .default,
            delegate: SSLPinningDelegate(),
            delegateQueue: nil
        )
    }
}
