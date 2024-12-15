//
//  UpdateWaterStatusViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 3.11.24.
//

import OSLog
import SwiftUI

@MainActor @Observable
final class UpdateWaterStatusViewModel {
    var ph = 0.0
    var chlorine = 0.0
    var alkalinity = 0.0
    var temperature = 0.0

    private(set) var isLoading = false
    private(set) var errorMessage: String?

    let poolId: Int
    let waterStatusId: Int

    private let apiClient: APIClient
    private let logger = Logger(
        subsystem: "com.clear.pool.water.status.update",
        category: "UpdateWaterStatusViewModel"
    )

    init(poolId: Int, waterStatusId: Int, apiClient: APIClient = APIManager()) {
        self.poolId = poolId
        self.waterStatusId = waterStatusId
        self.apiClient = apiClient
    }

    func fetchWaterStatus() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let waterStatus: WaterStatus = try await apiClient.execute(
                with: WaterStatusResource(id: waterStatusId)
            )

            updateFields(for: waterStatus)

            logger.info("Water status fetched successfully")
        } catch {
            errorMessage = "Unexpected Error!"
            logger.error("Water status fetch failed with error \(error.localizedDescription)")
        }
    }

    func updateWaterStatus() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let body = createWaterStatus()
            let waterStatus: WaterStatus = try await apiClient.execute(
                with: WaterStatusResource(id: waterStatusId, method: .put, body: body)
            )

            updateFields(for: waterStatus)

            logger.info("Water status saved successfully")
        } catch {
            errorMessage = "Unexpected Error!"
            logger.error("Water status save failed with error \(error.localizedDescription)")
        }
    }

    private func createWaterStatus() -> WaterStatus.Create {
        WaterStatus.Create(
            ph: ph,
            chlorine: chlorine,
            alkalinity: alkalinity.isNearlyEqual(to: 0) ? nil : alkalinity,
            temperature: temperature.isNearlyEqual(to: 0) ? nil : temperature,
            pool: poolId
        )
    }

    private func updateFields(for waterStatus: WaterStatus) {
        ph = waterStatus.ph
        chlorine = waterStatus.chlorine
        alkalinity = waterStatus.alkalinity ?? 0
        temperature = waterStatus.temperature ?? 0
    }
}
