//
//  Untitled.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

import Vision

extension VNClassificationObservation {
    /// Generates a string of the observation's confidence as a percentage.
    var confidencePercentageString: String {
        String(format: "%.2f", confidence * 100)
    }
}
