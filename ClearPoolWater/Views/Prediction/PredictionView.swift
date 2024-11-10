//
//  PredictionView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

import PhotosUI
import SwiftUI

struct PredictionView: View {
    @State private var viewModel = PoolPredictionViewModel()

    var body: some View {
        ZStack {
            BackgroundView()

            VStack(spacing: 40) {
                PredictionImageButton(
                    image: $viewModel.poolImage,
                    selectedPhoto: $viewModel.selectedPhoto
                )

                PredictButton(
                    isLoading: viewModel.isLoading,
                    isDisabled: !viewModel.isPredictionPossible
                ) {
                    Task {
                        await viewModel.predict()
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.resultPredictions, id: \.self) { result in
                            PredictionResultView(prediction: result)
                                .frame(width: 300)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}

#Preview {
    PredictionView()
}
