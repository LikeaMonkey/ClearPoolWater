//
//  Untitled.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct AdjustmentSection: View {
    @Binding var currentValue: Double
    @Binding var targetValue: Double

    var body: some View {
        VStack {
            TitledView(title: "Current pH") {
                SliderTextFieldView(
                    value: $currentValue,
                    range: 0...14,
                    step: 0.1
                )
            }
            TitledView(title: "Target pH") {
                SliderTextFieldView(
                    value: $targetValue,
                    range: 0...14,
                    step: 0.1
                )
            }
        }
    }
}

#Preview {
    AdjustmentSection(currentValue: .constant(1), targetValue: .constant(2))
}
