//
//  WaterStatusResource.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

struct WaterStatusResource: APIResource {
    var path: String {
        if let poolId {
            return "/api/pools/\(poolId)/waterStatus"
        }
        return "/api/waterStatus"
    }

    var id: Int? { _id }

    var method: HTTPMethod
    var body: WaterStatus.Create?

    private let _id: Int?
    private let poolId: Int?

    init(
        id: Int? = nil,
        method: HTTPMethod = .get,
        body: WaterStatus.Create? = nil
    ) {
        _id = id
        self.poolId = nil
        self.method = method
        self.body = body
    }

    init(poolId: Int) {
        _id = nil
        self.poolId = poolId
        self.method = .get
    }
}
