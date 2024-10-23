//
//  AuthManaging.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

protocol AuthManaging {
    var accessToken: String? { get }
    var userId: Int? { get }

    func login(with userToken: UserToken)
    func logout()
}
