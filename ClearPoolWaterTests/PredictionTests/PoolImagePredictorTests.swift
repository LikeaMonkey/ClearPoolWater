//
//  PoolImagePredictorTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 1.11.24.
//

import Testing

@testable import ClearPoolWater

struct PoolImagePredictorTests {
    @Test func testPrediction() async throws {
        let image = ImageUtils.createTestCGImage()
        let predictions = try await PoolImagePredictor().makePredictions(for: image)
        #expect(!predictions.isEmpty)
    }
}
