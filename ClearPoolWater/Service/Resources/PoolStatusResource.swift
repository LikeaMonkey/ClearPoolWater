//
//  P.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

struct PoolStatusResource: APIResource {
    var path: String {
        poolId != nil ? "/api/poolStatus/pool" : "/api/poolStatus"
    }

    var id: Int? { poolId ?? _id }

    var method: HTTPMethod
    var body: PoolStatus.Create?

    private let _id: Int?
    private let poolId: Int?

    init(
        id: Int? = nil,
        poolId: Int? = nil,
        method: HTTPMethod = .get,
        body: PoolStatus.Create? = nil
    ) {
        _id = id
        self.poolId = poolId
        self.method = method
        self.body = body
    }
}
