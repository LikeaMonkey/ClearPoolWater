//
//  PredictionResultView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 7.11.24.
//

import SwiftUI

struct PredictionResultView: View {
    let prediction: ImagePrediction

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Text(prediction.classification)
                    .font(.headline)

                Spacer()

                HStack {
                    Image(systemName: "lasso.badge.sparkles")
                    Text("\(prediction.confidencePercentageString)%")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
            }

            Divider()

            VStack(spacing: 12) {
                HStack {
                    Image(systemName: "heart.text.clipboard")
                    Text("Treatment Recommendations")
                }
                .font(.subheadline)
                .fontWeight(.medium)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Check & Balance Water Chemistry")
                    Text("Shock the Pool")
                    Text("Use a Pool Clarifier")
                    Text("Run the Filter")
                    Text("Brush & Vacuum")
                    Text("Re-test Water")
                }
                .font(.caption)
            }
            .padding(.top, 10)
        }
        .padding(20)
        .background(.regularMaterial)
        .cornerRadius(25)
    }
}

#Preview {
    let prediction = ImagePrediction(classification: "Cloudy Water", confidence: 0.9875)
    PredictionResultView(prediction: prediction)
}
