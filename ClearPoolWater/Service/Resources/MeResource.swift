//
//  MeResource.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

struct MeResource: APIResource {
    typealias ModelType = User

    var path: String { "/me" }
    var method: HTTPMethod { .get }
}
