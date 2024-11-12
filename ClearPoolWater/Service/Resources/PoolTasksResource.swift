//
//  PoolTasksResource.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

struct PoolTasksResource: APIResource {
    typealias ModelType = PoolTask

    var path: String { "/api/pools/\(poolId)/tasks" }

    private let poolId: Int

    init(poolId: Int) {
        self.poolId = poolId
    }
}
