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

    var onReadTemperature: ((Float?) -> Void)?
    var onPeripheralReady: (() -> Void)?
    var onError: ((Error) -> Void)?

    var discoveredServices = [CBUUID: CBService]()
    var discoveredCharacteristics = [CBUUID: CBCharacteristic]()

    func discoverServices() {
        peripheral?.discoverServices([UUIDs.sensorService])
    }

    func readTemperature() {
        guard let tempCharacteristic = discoveredCharacteristics[UUIDs.temperatureCharacteristic]
        else {
            return
        }

        peripheral?.readValue(for: tempCharacteristic)
    }

    fileprivate func requiredCharacteristicUUIDs(for service: CBService) -> [CBUUID] {
        switch service.uuid {
        case UUIDs.sensorService
        where discoveredCharacteristics[UUIDs.temperatureCharacteristic] == nil:
            return [UUIDs.temperatureCharacteristic]
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

        if discoveredCharacteristics[UUIDs.temperatureCharacteristic] != nil {
            onPeripheralReady?()
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didUpdateValueFor characteristic: CBCharacteristic,
        error: Error?
    ) {
        switch characteristic.uuid {
        case UUIDs.temperatureCharacteristic:
            let value = characteristic.value?.withUnsafeBytes { $0.load(as: Float.self) }
            onReadTemperature?(value)
        default:
            fatalError()
        }
    }
}
