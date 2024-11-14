//
//  MockImagePredictor.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import PhotosUI
import SwiftUI

@testable import ClearPoolWater

final class MockImagePredictor: ImagePredictor {
    let predictions: [ImagePrediction]

    init(predictions: [ImagePrediction] = []) {
        self.predictions = predictions
    }

    func makePredictions(for photo: CGImage) async throws -> [ImagePrediction] {
        predictions
    }
}
