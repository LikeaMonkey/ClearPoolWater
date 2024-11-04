//
//  ColorEvaluator.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 3.11.24.
//

import SwiftUI

struct ColorEvaluator {
    static func evaluateColor(
        for value: Double?,
        in idealRange: ClosedRange<Double>
    ) -> Color {
        guard let value else { return .gray }

        if idealRange.contains(value) {
            return .green
        }

        let threshold = (idealRange.upperBound - idealRange.lowerBound) * 0.2
        let lowerBound = idealRange.lowerBound - threshold
        let upperBound = idealRange.upperBound + threshold
        return (value < lowerBound || value > upperBound) ? .red : .yellow
    }
}
