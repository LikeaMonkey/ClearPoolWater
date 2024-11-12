//
//  P.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

struct PoolStatusResource: APIResource {
    var path: String {
        if let poolId {
            return "/api/pools/\(poolId)/poolStatus"
        }
        return "/api/poolStatus"
    }

    var id: Int? { _id }

    var method: HTTPMethod
    var body: PoolStatus.Create?

    private let _id: Int?
    private let poolId: Int?

    init(
        id: Int? = nil,
        method: HTTPMethod = .get,
        body: PoolStatus.Create? = nil
    ) {
        _id = id
        poolId = nil
        self.method = method
        self.body = body
    }

    init(poolId: Int) {
        _id = nil
        self.poolId = poolId
        self.method = .get
    }
}
