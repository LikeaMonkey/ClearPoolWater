//
//  MetricsSession.swift
//  Test - Test 1
//
//  Created by Stanimir Hristov on 9.10.24.
//

import Foundation

final class MetricsSessionDelegate: NSObject, URLSessionTaskDelegate {
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didFinishCollecting metrics: URLSessionTaskMetrics
    ) {
        for metric in metrics.transactionMetrics {
            if let protocolName = metric.networkProtocolName {
                print("Protocol used: \(protocolName)")
            }
        }
    }
}
