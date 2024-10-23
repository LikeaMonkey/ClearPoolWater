//
//  User.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

struct User: Codable {
    var id: Int
    var email: String
    var role: Role

    enum Role: String, Codable {
        case admin
        case user
        case paidUser = "paid_user"
    }

    struct Create: Codable {
        let email: String
        let password: String
        let confirmPassword: String
        let role: Role
    }
}
