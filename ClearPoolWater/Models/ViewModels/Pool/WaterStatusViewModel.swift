//
//  WaterStatusViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

import OSLog
import SwiftUI

@MainActor @Observable
final class WaterStatusViewModel {
    var ph: Double?
    var chlorine: Double?
    var alkalinity: Double?
    var temperature: Double?

    var waterStatusId: Int?
    var isLoaded: Bool { waterStatusId != nil }

    private(set) var isLoading = false
    private(set) var errorMessage: String?

    private var poolId: Int?
    private let apiClient: APIClient

    private let logger = Logger(
        subsystem: "com.clear.pool.water.status",
        category: "WaterStatusViewModel"
    )

    init(apiClient: APIClient = APIManager()) {
        self.apiClient = apiClient
    }

    func setup(poolId: Int) {
        self.poolId = poolId
    }

    func fetchWaterStatus() async {
        guard let poolId else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let waterStatus: WaterStatus = try await apiClient.execute(
                with: WaterStatusResource(poolId: poolId)
            )
            waterStatusId = waterStatus.id

            updateFields(for: waterStatus)

            logger.info("Water status fetched successfully")
        } catch {
            errorMessage = "Unexpected Error!"
            logger.error("Water status fetch failed with error \(error.localizedDescription)")
        }
    }

    private func updateFields(for waterStatus: WaterStatus) {
        ph = waterStatus.ph
        chlorine = waterStatus.chlorine
        alkalinity = waterStatus.alkalinity
        temperature = waterStatus.temperature
    }
}
