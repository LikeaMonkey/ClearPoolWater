//
//  SensorMonitor.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 8.12.24.
//

import CoreBluetooth

final class SensorMonitor: NSObject {
    var peripheral: CBPeripheral? {
        didSet {
            peripheral?.delegate = self
            discoverServices()
        }
    }

    var onReadPh: ((Float?) -> Void)?
    var onPeripheralReady: (() -> Void)?
    var onError: ((Error) -> Void)?

    var discoveredServices = [CBUUID: CBService]()
    var discoveredCharacteristics = [CBUUID: CBCharacteristic]()

    func discoverServices() {
        peripheral?.discoverServices([UUIDs.sensorService])
    }

    func readPh() {
        guard let phCharacteristic = discoveredCharacteristics[UUIDs.phCharacteristic]
        else {
            return
        }

        peripheral?.readValue(for: phCharacteristic)
    }

    fileprivate func requiredCharacteristicUUIDs(for service: CBService) -> [CBUUID] {
        switch service.uuid {
        case UUIDs.sensorService where discoveredCharacteristics[UUIDs.phCharacteristic] == nil:
            return [UUIDs.phCharacteristic]
        default:
            return []
        }
    }
}

extension SensorMonitor: CBPeripheralDelegate {
    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverServices error: Error?
    ) {
        guard let services = peripheral.services, error == nil else {
            return
        }

        for service in services {
            discoveredServices[service.uuid] = service
            let uuids = requiredCharacteristicUUIDs(for: service)
            guard !uuids.isEmpty else {
                return
            }
            peripheral.discoverCharacteristics(uuids, for: service)
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverCharacteristicsFor service: CBService,
        error: Error?
    ) {
        guard let characteristics = service.characteristics else {
            return
        }

        for characteristic in characteristics {
            discoveredCharacteristics[characteristic.uuid] = characteristic
        }

        if discoveredCharacteristics[UUIDs.phCharacteristic] != nil {
            onPeripheralReady?()
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didUpdateValueFor characteristic: CBCharacteristic,
        error: Error?
    ) {
        switch characteristic.uuid {
        case UUIDs.phCharacteristic:
            let value = characteristic.value?.withUnsafeBytes { $0.load(as: Float.self) }
            onReadPh?(value)
        default:
            fatalError()
        }
    }
}
