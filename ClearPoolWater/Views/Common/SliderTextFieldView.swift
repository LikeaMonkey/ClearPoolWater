//
//  SliderTextFieldView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 3.11.24.
//

import SwiftUI

struct SliderTextFieldView: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double.Stride

    var body: some View {
        HStack {
            Slider(value: $value, in: range, step: step)
            NumericTextField(value: $value, range: range)
                .frame(width: 60)
        }
    }
}

#Preview {
    SliderTextFieldView(value: .constant(0), range: 0...1, step: 0.1)
}
