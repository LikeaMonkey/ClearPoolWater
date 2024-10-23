//
//  URLProvider.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import Foundation

protocol URLProviding {
    var loginURL: URL { get }
    var registerURL: URL { get }
    var meURL: URL { get }

    var poolsURL: URL { get }
    func poolsURL(poolId: Int) -> URL
    func poolsURL(userId: Int) -> URL

    var poolStatusURL: URL { get }
    func poolStatusURL(poolStatusId: Int) -> URL
    func poolStatusURL(poolId: Int) -> URL

    var waterStatusURL: URL { get }
    func waterStatusURL(waterStatusId: Int) -> URL
    func waterStatusURL(poolId: Int) -> URL
}
