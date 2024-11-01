//
//  LoginResource.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

struct LoginResource: APIResource {
    typealias ModelType = UserToken

    var path: String { "/login" }
    var method: HTTPMethod { .post }
    var headers: [String: String]?

    init(email: String, password: String) {
        headers = APIUtils.basicAuthHeaders(email: email, password: password)
    }
}
