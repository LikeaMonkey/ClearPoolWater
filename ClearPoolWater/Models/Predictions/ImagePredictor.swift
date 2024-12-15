//
//  ImagePredictor.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 1.11.24.
//

import CoreGraphics

protocol ImagePredictor: Sendable {
    func makePredictions(for photo: CGImage) async throws -> [ImagePrediction]
}
