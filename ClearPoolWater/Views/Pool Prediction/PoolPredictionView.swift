//
//  PoolPredictionView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

import PhotosUI
import SwiftUI

struct PoolPredictionView: View {
    @State private var viewModel = PoolPredictionViewModel()

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                viewModel.poolImage?
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()

                PhotosPicker(
                    "Select Pool Photo",
                    selection: $viewModel.selectedPhoto,
                    matching: .images
                )

                Button {
                    Task {
                        await viewModel.predict()
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Predict")
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.isPredictionPossible)
            }

            if !viewModel.resultPredictions.isEmpty {
                VStack {
                    ForEach(viewModel.resultPredictions, id: \.self) { prediction in
                        Text("\(prediction.result) - \(prediction.confidence)%")
                    }
                }
            }
        }
    }
}

#Preview {
    PoolPredictionView()
}
