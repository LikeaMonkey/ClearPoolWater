//
//  ImagePrediction.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 1.11.24.
//

/// Stores a classification name and confidence for an image classifier's prediction.
struct ImagePrediction: Hashable {
    let classification: String
    let confidence: Float

    var confidencePercentageString: String {
        String(format: "%.2f", confidence * 100)
    }
}
