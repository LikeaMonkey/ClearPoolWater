//
//  PoolPredictionViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import PhotosUI
import SwiftUI
import Testing

@testable import ClearPoolWater

//struct PoolPredictionViewModelTests {
//    @Test(.disabled("Known issue"))
//    func testIsPredictEnabled() async {
//        let image = ImageUtils.createTestImage()
//        let imageLoader = MockImageLoader(image: image)
//        let model = PoolPredictionViewModel(
//            poolImagePredictor: MockImagePredictor(),
//            imageLoader: imageLoader
//        )
//
//        model.selectedPhoto = PhotosPickerItem(itemIdentifier: "")
//
//        #expect(model.isPredictionPossible)
//    }
//
//    @Test
//    func testPredictDisabled() async {
//        let model = PoolPredictionViewModel(
//            poolImagePredictor: MockImagePredictor(),
//            imageLoader: MockImageLoader()
//        )
//
//        #expect(!model.isPredictionPossible)
//    }
//
//    @Test
//    func testPoolImage() async {
//        let image = ImageUtils.createTestImage()
//        let imageLoader = MockImageLoader(image: image)
//        let model = PoolPredictionViewModel(
//            poolImagePredictor: MockImagePredictor(),
//            imageLoader: imageLoader
//        )
//
//        model.selectedPhoto = PhotosPickerItem(itemIdentifier: "")
//
//        Task {
//            #expect(model.poolImage != nil)
//        }
//    }
//
//    @Test
//    func testNoPoolImage() async {
//        let model = PoolPredictionViewModel(
//            poolImagePredictor: MockImagePredictor(),
//            imageLoader: MockImageLoader()
//        )
//
//        model.selectedPhoto = PhotosPickerItem(itemIdentifier: "")
//
//        Task {
//            #expect(model.poolImage == nil)
//        }
//    }
//
//    @Test
//    func testPoolPredictions() async {
//        let image = ImageUtils.createTestImage()
//        let imageLoader = MockImageLoader(image: image)
//
//        let predictions = [
//            ImagePrediction(classification: "Test 1", confidence: 0.9),
//            ImagePrediction(classification: "Test 2", confidence: 0.1),
//        ]
//        let imagePredictor = MockImagePredictor(predictions: predictions)
//
//        let model = PoolPredictionViewModel(
//            poolImagePredictor: imagePredictor,
//            imageLoader: imageLoader
//        )
//
//        model.selectedPhoto = PhotosPickerItem(itemIdentifier: "")
//
//        Task {
//            await model.predict()
//
//            #expect(model.resultPredictions.count == 2)
//        }
//    }
//
//    @Test
//    func testNoPoolPredictions() async {
//        let image = ImageUtils.createTestImage()
//        let imageLoader = MockImageLoader(image: image)
//        let model = PoolPredictionViewModel(
//            poolImagePredictor: MockImagePredictor(),
//            imageLoader: imageLoader
//        )
//
//        model.selectedPhoto = PhotosPickerItem(itemIdentifier: "")
//
//        Task {
//            await model.predict()
//
//            #expect(model.resultPredictions.isEmpty)
//        }
//    }
//
//    @Test
//    func testPoolPredictionsFiltering() async {
//        let image = ImageUtils.createTestImage()
//        let imageLoader = MockImageLoader(image: image)
//
//        let predictions = [
//            ImagePrediction(classification: "Test 1", confidence: 0.96),
//            ImagePrediction(classification: "Test 2", confidence: 0.03),
//            ImagePrediction(classification: "Test 3", confidence: 0.01),
//        ]
//        let imagePredictor = MockImagePredictor(predictions: predictions)
//
//        let model = PoolPredictionViewModel(
//            poolImagePredictor: imagePredictor,
//            imageLoader: imageLoader
//        )
//
//        model.selectedPhoto = PhotosPickerItem(itemIdentifier: "")
//
//        Task {
//            await model.predict()
//
//            #expect(model.resultPredictions.count == 1)
//            #expect(model.resultPredictions[0] == predictions[0])
//        }
//    }
//}
