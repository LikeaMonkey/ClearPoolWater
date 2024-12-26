//
//  DeviceDetailViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 8.12.24.
//

import CoreBluetooth
import OSLog
import SwiftUI

@MainActor @Observable
final class DeviceDetailViewModel {
    let pool: Pool
    let waterStatus: WaterStatus
    let device: CBPeripheral

    private(set) var isLoading = false
    private(set) var lastUpdated = ""

    private var isDeviceReady = false
    private var phValue: Float?

    var phText: String {
        logger.info("Water status \(String(describing: self.waterStatus))")
        return phValue?.formatted(.number.precision(.fractionLength(0...1))) ?? "-"
    }

    var isReady: Bool {
        logger.info("Water status \(String(describing: self.waterStatus))")
        return isDeviceReady && phValue != nil
    }

    private let apiClient: APIClient
    private let logger = Logger(
        subsystem: "com.clear.pool.water.status.device.scan",
        category: "DeviceDetailViewModel"
    )

    private let sensorMonitor: SensorMonitor
    private var phTask: Task<Void, Never>?

    init(
        pool: Pool,
        waterStatus: WaterStatus,
        device: CBPeripheral,
        apiClient: APIClient = APIManager()
    ) {
        self.pool = pool
        self.waterStatus = waterStatus
        self.device = device

        self.apiClient = apiClient

        sensorMonitor = SensorMonitor()
        sensorMonitor.onPeripheralReady = { [weak self] in
            guard let self, !isDeviceReady else { return }

            isDeviceReady = true
            startTemperatureUpdates()
        }
        sensorMonitor.onReadPh = { [weak self] value in
            self?.phValue = value
            self?.lastUpdated = Date().formatted(date: .omitted, time: .standard)
        }
        sensorMonitor.onError = { [weak self] error in
            self?.logger
                .error("Device failed to read ph data with error - \(error.localizedDescription)")
        }
        sensorMonitor.peripheral = device
    }

    var navigationTitle: String { device.name ?? "Unknown" }

    private func startTemperatureUpdates() {
        stopTemperatureUpdates()  // Ensure no previous task is running

        phTask = Task {
            while !Task.isCancelled {
                sensorMonitor.readPh()
                try? await Task.sleep(for: .seconds(5))
            }
        }
    }

    func stopTemperatureUpdates() {
        phTask?.cancel()
        phTask = nil
    }

    func updateWaterStatus() async {
        guard let phValue else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let ph = Double(phValue)
            let body = createWaterStatus(ph: ph)
            let _: WaterStatus = try await apiClient.execute(
                with: WaterStatusResource(id: waterStatus.id, method: .put, body: body)
            )

            logger.info("Water status saved successfully")
        } catch {
            logger.error("Water status save failed with error \(error.localizedDescription)")
        }
    }

    private func createWaterStatus(ph: Double) -> WaterStatus.Create {
        WaterStatus.Create(
            ph: ph,
            chlorine: waterStatus.chlorine,
            alkalinity: waterStatus.alkalinity,
            temperature: waterStatus.temperature,
            pool: pool.id
        )
    }
}
