//
//  WaterStatusResource.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

struct WaterStatusResource: APIResource {
    var path: String {
        poolId != nil ? "/api/waterStatus/pool" : "/api/waterStatus"
    }

    var id: Int? { poolId ?? _id }

    var method: HTTPMethod
    var body: WaterStatus.Create?

    private let _id: Int?
    private let poolId: Int?

    init(
        id: Int? = nil,
        poolId: Int? = nil,
        method: HTTPMethod = .get,
        body: WaterStatus.Create? = nil
    ) {
        _id = id
        self.poolId = poolId
        self.method = method
        self.body = body
    }
}
