//
//  PoolImagePredictor.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

import SwiftUI
import Vision

/// A convenience class that makes image classification predictions.
///
/// The Image Predictor creates and reuses an instance of a Core ML image classifier inside a ``VNCoreMLRequest``.
final class PoolImagePredictor: ImagePredictor {
    static func createImageClassifier() -> VNCoreMLModel {
        guard let imageClassifier = try? PoolMaintenanceClassifier() else {
            fatalError("App failed to create a pool image classifier model instance.")
        }
        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifier.model) else {
            fatalError("App failed to create a `VNCoreMLModel` instance.")
        }

        return imageClassifierVisionModel
    }

    /// Shared image classifier instance for ImagePrediction.
    private static let poolImageClassifier = createImageClassifier()

    /// Asynchronous function for generating image classification ImagePredictions.
    /// - Parameter photo: An image, typically of an object or a scene.
    /// - Returns: An array of `ImagePrediction` or throws an error if ImagePrediction fails.
    func makePredictions(for photo: CGImage) async throws -> [ImagePrediction] {
        return try await withCheckedThrowingContinuation { continuation in
            let handler = VNImageRequestHandler(cgImage: photo)
            let request = createImageClassificationRequest(with: continuation)
            try? handler.perform([request])
        }
    }

    /// Generates a new request instance that uses the PoolImagePredictor's image classifier model.
    private func createImageClassificationRequest(
        with continuation: CheckedContinuation<[ImagePrediction], Error>
    ) -> VNCoreMLRequest {
        let request = VNCoreMLRequest(
            model: PoolImagePredictor.poolImageClassifier
        ) { [weak self] request, error in
            self?.handleClassificationResult(request, error: error, continuation: continuation)
        }

        request.imageCropAndScaleOption = .centerCrop

        #if targetEnvironment(simulator)
            if #available(iOS 18.0, *) {
                let allDevices = MLComputeDevice.allComputeDevices
                for device in allDevices {
                    if case .cpu = device {
                        request.setComputeDevice(device, for: .main)
                        break
                    }
                }
            } else {
                // Fallback on earlier versions
                request.usesCPUOnly = true
            }
        #endif

        return request
    }

    private func handleClassificationResult(
        _ request: VNRequest,
        error: Error?,
        continuation: CheckedContinuation<[ImagePrediction], Error>
    ) {
        if let error = error {
            continuation.resume(
                throwing: PoolImagePredictorError.visionError(error.localizedDescription)
            )
            return
        }

        guard let observations = request.results as? [VNClassificationObservation] else {
            continuation.resume(throwing: PoolImagePredictorError.unexpectedResultType)
            return
        }

        let imagePredictions = observations.map { observation in
            ImagePrediction(
                classification: observation.identifier,
                confidence: observation.confidence
            )
        }

        continuation.resume(returning: imagePredictions)
    }
}
