//
//  CalculatorResultView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct CalculatorResultView: View {
    let resultMessage: String

    init(resultValue: Double?) {
        if let resultValue {
            resultMessage = "Add \(resultValue.formatted()) gr"
        } else {
            resultMessage = "Need more info"
        }
    }

    var body: some View {
        HStack {
            Text("Result: ")
            Text(resultMessage)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CalculatorResultView(resultValue: nil)
    CalculatorResultView(resultValue: 100)
}
