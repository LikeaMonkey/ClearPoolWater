//
//  WaterStatusViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

import OSLog
import SwiftUI

@Observable
final class WaterStatusViewModel {
    var ph = ""
    var chlorine = ""
    var alkalinity = ""
    var temperature = ""

    private(set) var isLoading = false
    private(set) var errorMessage: String?

    let poolId: Int
    private let apiClient: APIClient

    private var waterStatusId: Int?

    private let logger = Logger(
        subsystem: "com.clear.pool.water.status",
        category: "WaterStatusViewModel"
    )

    init(poolId: Int, apiClient: APIClient = APIManager()) {
        self.poolId = poolId
        self.apiClient = apiClient
    }

    func fetchWaterStatus() async {
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

    // TODO: Extract save to separate view model
    func updateWaterStatus() async {
        guard let waterStatusId else {
            logger.error("WaterStatus ID must be set")
            return
        }

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
        let formatter = DecimalFormatter()
        let ph = formatter.double(from: ph) ?? 0
        let chlorine = formatter.double(from: chlorine) ?? 0
        let alkalinity = alkalinity.isEmpty ? nil : Double(alkalinity)
        let temperature = temperature.isEmpty ? nil : Double(temperature)

        return WaterStatus.Create(
            ph: ph,
            chlorine: chlorine,
            alkalinity: alkalinity,
            temperature: temperature,
            pool: poolId
        )
    }

    private func updateFields(for waterStatus: WaterStatus) {
        withAnimation {
            ph = waterStatus.ph.formatted()
            chlorine = waterStatus.chlorine.formatted()
            if let newAlkalinity = waterStatus.alkalinity {
                alkalinity = newAlkalinity.formatted()
            }
            if let newTemperature = waterStatus.temperature {
                temperature = newTemperature.formatted()
            }
        }
    }
}
