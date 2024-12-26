//
//  PoolVolumeSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct PoolVolumeSection: View {
    @Binding var poolVolumeValue: Double
    @FocusState.Binding var focusedField: WaterBalanceCalculatorFocusField?

    var body: some View {
        TitledView(title: "Pool Volume") {
            SliderTextFieldView(
                value: $poolVolumeValue,
                range: 0...150,
                step: 0.5
            )
            .focused($focusedField, equals: .volume)
        }
    }
}

#Preview {
    let focusedField = FocusState<WaterBalanceCalculatorFocusField?>().projectedValue
    PoolVolumeSection(poolVolumeValue: .constant(1), focusedField: focusedField)
}
