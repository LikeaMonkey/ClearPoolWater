//
//  PoolResource.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

struct PoolResource: APIResource {
    var path: String {
        userId != nil ? "/api/pools/user" : "/api/pools"
    }

    var id: Int? { userId ?? _id }

    var method: HTTPMethod
    var body: Pool.Create?

    private let _id: Int?
    private let userId: Int?

    init(
        id: Int? = nil,
        userId: Int? = nil,
        method: HTTPMethod = .get,
        body: Pool.Create? = nil
    ) {
        _id = id
        self.userId = userId
        self.method = method
        self.body = body
    }
}
