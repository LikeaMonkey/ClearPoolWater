//
//  PredictButton.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 7.11.24.
//

import SwiftUI

struct PredictButton: View {
    let isLoading: Bool
    let isDisabled: Bool
    let predictAction: () -> Void

    var body: some View {
        Button {
            predictAction()
        } label: {
            if isLoading {
                ProgressView()
                    .frame(width: 280)
            } else {
                Text("Predict")
                    .frame(width: 280)
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .disabled(isDisabled)
    }
}

#Preview {
    PredictButton(isLoading: false, isDisabled: false) {}
}
