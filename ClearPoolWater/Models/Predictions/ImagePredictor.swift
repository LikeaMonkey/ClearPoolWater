//
//  ImagePredictor.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 1.11.24.
//

import CoreGraphics

@MainActor
protocol ImagePredictor {
    func makePredictions(for photo: CGImage) async throws -> [ImagePrediction]
}
