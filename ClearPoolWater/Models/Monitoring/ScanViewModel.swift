//
//  ScanViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 8.12.24.
//

import CoreBluetooth
import SwiftUI

@Observable
final class ScanViewModel {
    var devices: [CBPeripheral] = []

    var showConnectedDetail = false
    var connectedDevice: CBPeripheral?

    private var centralManager: Scanable
    private var foundDevices: Set<CBPeripheral> = []

    init(centralManager: Scanable = ScanManager()) {
        self.centralManager = centralManager
        self.centralManager.delegate = self
    }

    private func scan() {
        centralManager.scan(for: [UUIDs.sensorService])
    }

    func connect(to peripheral: CBPeripheral) {
        centralManager.connect(to: peripheral)
    }

    func disconnect() {
        guard let connectedDevice else { return }
        centralManager.disconnect(from: connectedDevice)
    }
}

extension ScanViewModel: ScanableDelegate {
    func didBecomeReady() {
        scan()
    }

    func onDiscovery(peripheral: CBPeripheral) {
        foundDevices.insert(peripheral)
        devices = Array(foundDevices)
    }

    func onConnect(peripheral: CBPeripheral) {
        connectedDevice = peripheral
        showConnectedDetail = true
    }

    func onDisconnect(peripheral: CBPeripheral) {
        connectedDevice = nil
        showConnectedDetail = false
    }
}
