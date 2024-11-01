//
//  WaterTraitSlider.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

import SwiftUI

struct WaterTraitSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let title: LocalizedStringKey

    @State private var isEditing: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text(title)
                Text(value.formatted())
                    .foregroundColor(isEditing ? .red : .blue)
            }

            Slider(value: $value, in: range, step: step) {
                Text(title)
            } minimumValueLabel: {
                Text(range.lowerBound.formatted())
            } maximumValueLabel: {
                Text(range.upperBound.formatted())
            } onEditingChanged: { value in
                isEditing = value
            }
        }
    }
}

#Preview {
    WaterTraitSlider(
        value: .constant(0),
        range: 0...1,
        step: 0.1,
        title: .init(stringLiteral: "Water")
    )
}
