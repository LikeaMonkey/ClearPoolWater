//
//  PoolImagePredictorError.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 1.11.24.
//

enum PoolImagePredictorError: Error {
    case unexpectedResultType
    case visionError(String)
}
