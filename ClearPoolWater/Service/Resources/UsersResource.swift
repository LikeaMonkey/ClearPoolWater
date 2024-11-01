//
//  UsersResource.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

struct UsersResource: APIResource {
    var path: String { "/api/users" }
    var id: Int?

    var method: HTTPMethod
    var body: User.Create?

    init(
        id: Int? = nil,
        method: HTTPMethod = .get,
        body: User.Create? = nil
    ) {
        self.id = id
        self.method = method
        self.body = body
    }
}
