//
//  PoolPredictionViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 1.11.24.
//

import CoreML
import OSLog
import PhotosUI
import SwiftUI

struct PoolPrediction: Hashable {
    var result: String
    var confidence: String
}

@Observable
final class PoolPredictionViewModel {
    var selectedPhoto: PhotosPickerItem? {
        didSet {
            Task {
                await loadSelectedPhotoData()
                updatePoolImage()
            }
        }
    }

    var poolImage: Image?
    var resultPredictions: [PoolPrediction] = []

    private(set) var isLoading = false
    var isPredictionPossible: Bool { selectedPhoto != nil && !isLoading }

    private let poolImagePredictor: ImagePredictor

    private var imageData: Data?

    private let logger = Logger(
        subsystem: "com.clear.pool.water.pool.prediction",
        category: "PoolPredictionViewModel"
    )

    init(poolImagePredictor: ImagePredictor = PoolImagePredictor()) {
        self.poolImagePredictor = poolImagePredictor
    }

    func predict() async {
        isLoading = true
        defer { isLoading = false }

        guard let imageData, let imagePhoto = UIImage(data: imageData)?.cgImage else {
            logger.error("Failed to load image photo for prediction")
            return
        }

        do {
            let predictions = try await poolImagePredictor.makePredictions(for: imagePhoto)

            resultPredictions = predictions.map {
                PoolPrediction(
                    result: $0.classification,
                    confidence: $0.confidencePercentage
                )
            }
        } catch {
            logger.error("Failed to make predictions for photo: \(error)")
        }
    }

    private func loadSelectedPhotoData() async {
        isLoading = true
        defer { isLoading = false }

        guard let data = try? await selectedPhoto?.loadTransferable(type: Data.self) else {
            logger.error("Failed to load selected photo data")
            return
        }

        imageData = data
    }

    private func updatePoolImage() {
        guard let imageData, let image = UIImage(data: imageData) else {
            logger.error("Failed to update pool image")
            return
        }

        poolImage = Image(uiImage: image)
    }
}
