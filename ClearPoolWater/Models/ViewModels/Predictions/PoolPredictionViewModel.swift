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

@MainActor @Observable
final class PoolPredictionViewModel {
    var selectedPhoto: PhotosPickerItem? {
        didSet {
            Task {
                await loadSelectedPhotoData()
                updatePoolImage()
            }
        }
    }

    var selectedCameraImage: UIImage? {
        didSet {
            loadSelectedCameraImageData()
            updatePoolImage()
        }
    }

    var poolImage: Image?

    var resultPredictions: [ImagePrediction] = []

    var isPredictionPossible: Bool {
        imageData != nil && !isLoading
    }

    private(set) var isLoading = false

    private var imageData: Data?

    private let poolImagePredictor: ImagePredictor
    private let imageLoader: ImageLoading
    private let logger = Logger(
        subsystem: "com.clear.pool.water.pool.prediction",
        category: "PoolPredictionViewModel"
    )

    init(
        poolImagePredictor: ImagePredictor = PoolImagePredictor(),
        imageLoader: ImageLoading = PhotosImageLoader()
    ) {
        self.poolImagePredictor = poolImagePredictor
        self.imageLoader = imageLoader
    }

    func predict() async {
        isLoading = true
        defer { isLoading = false }

        guard let imageData,
            let imagePhoto = imageLoader.loadImage(from: imageData)?.cgImage
        else {
            logger.error("Failed to load image photo for prediction")
            return
        }

        do {
            let predictions = try await poolImagePredictor.makePredictions(for: imagePhoto)
            resultPredictions = predictions.filter { $0.confidence >= 0.01 }

            logger.error("Make pool predictions successfully")
        } catch {
            resultPredictions = []

            logger.error("Failed to make predictions for photo: \(error.localizedDescription)")
        }
    }

    private func loadSelectedPhotoData() async {
        isLoading = true
        defer { isLoading = false }

        guard let selectedPhoto else {
            logger.error("No selected image to load")
            return
        }

        imageData = await imageLoader.loadImageData(from: selectedPhoto)
    }

    private func loadSelectedCameraImageData() {
        guard let selectedCameraImage else {
            logger.error("No selected camera image")
            return
        }

        imageData = imageLoader.loadImageData(from: selectedCameraImage)
    }

    private func updatePoolImage() {
        guard let imageData, let image = imageLoader.loadImage(from: imageData) else {
            logger.error("Failed to load pool image")
            return
        }

        poolImage = Image(uiImage: image)
    }
}
