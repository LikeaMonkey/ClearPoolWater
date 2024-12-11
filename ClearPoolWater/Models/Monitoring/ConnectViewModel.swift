//
//  DeviceDetailViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 8.12.24.
//

import CoreBluetooth
import SwiftUI

@Observable
final class DeviceDetailViewModel {
    let device: CBPeripheral

    var isDeviceReady = false
    var temperature: Float?

    private let sensorMonitor: SensorMonitor
    private var temperatureTask: Task<Void, Never>?

    init(device: CBPeripheral) {
        self.device = device

        sensorMonitor = SensorMonitor()
        sensorMonitor.peripheral = device
        sensorMonitor.onPeripheralReady = { [weak self] in
            self?.isDeviceReady = true
            self?.startTemperatureUpdates()
        }
        sensorMonitor.onReadTemperature = { [weak self] value in
            self?.temperature = value
        }
        sensorMonitor.onError = { _ in
            // TODO: Add error message
        }
    }

    var navigationTitle: String { device.name ?? "Unknown" }

    private func startTemperatureUpdates() {
        stopTemperatureUpdates()  // Ensure no previous task is running

        temperatureTask = Task {
            while !Task.isCancelled {
                await readTemperature()

                let seconds: UInt64 = 2
                try? await Task.sleep(nanoseconds: seconds * NSEC_PER_SEC)
            }
        }
    }

    private func readTemperature() async {
        sensorMonitor.readTemperature()
    }

    deinit {
        stopTemperatureUpdates()
    }

    private func stopTemperatureUpdates() {
        temperatureTask?.cancel()
        temperatureTask = nil
    }
}
