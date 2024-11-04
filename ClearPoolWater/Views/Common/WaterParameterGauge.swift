//
//  WaterParameterGauge.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 27.10.24.
//

import SwiftUI

struct WaterParameterGauge: View {
    private let name: LocalizedStringKey
    private let value: Double?
    private let range: ClosedRange<Double>
    private let tintColor: Color

    init(
        name: LocalizedStringKey,
        value: Double?,
        range: ClosedRange<Double>,
        idealRange: ClosedRange<Double>
    ) {
        self.name = name
        self.value = value
        self.range = range
        self.tintColor = ColorEvaluator.evaluateColor(for: value, in: idealRange)
    }

    var body: some View {
        Gauge(value: value ?? range.lowerBound, in: range) {
            Text(name)
        } currentValueLabel: {
            Text(value?.formatted() ?? "-")
        }
        .gaugeStyle(.accessoryCircular)
        .tint(tintColor)
    }
}

#Preview {
    WaterParameterGauge(name: "pH", value: 7.2, range: 0...14, idealRange: 7.2...7.6)
}
