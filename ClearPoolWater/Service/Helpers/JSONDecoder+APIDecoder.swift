//
//  JSONDecoder+APIDecoder.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 30.10.24.
//

import Foundation

extension JSONDecoder {
    static var apiDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
