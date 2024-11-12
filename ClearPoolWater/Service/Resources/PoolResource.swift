//
//  PoolResource.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

struct PoolResource: APIResource {
    var path: String { "/api/pools" }

    var id: Int? { _id }

    var method: HTTPMethod
    var body: Pool.Create?

    private let _id: Int?

    init(
        id: Int? = nil,
        method: HTTPMethod = .get,
        body: Pool.Create? = nil
    ) {
        _id = id
        self.method = method
        self.body = body
    }
}
