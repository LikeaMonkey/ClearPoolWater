//
//  NumericTextField.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 3.11.24.
//

import SwiftUI

struct NumericTextField: View {
    @Binding var value: Double
    let range: ClosedRange<Double>

    var body: some View {
        TextField("", value: $value, formatter: NumberFormatter.decimal())
            .textFieldStyle(.roundedBorder)
            .keyboardType(.decimalPad)
            .onChange(of: value) { _, newValue in
                if newValue < range.lowerBound {
                    value = range.lowerBound
                } else if newValue > range.upperBound {
                    value = range.upperBound
                }
            }
    }
}

#Preview {
    NumericTextField(value: .constant(0), range: 0...1)
}
