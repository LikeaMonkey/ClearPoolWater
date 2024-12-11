//
//  ScanManager.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 8.12.24.
//

import CoreBluetooth

protocol Scanable {
    var delegate: ScanableDelegate? { get set }

    func scan(for services: [CBUUID])
    func connect(to peripheral: CBPeripheral)
    func disconnect(from peripheral: CBPeripheral)
}

protocol ScanableDelegate: AnyObject {
    func didBecomeReady()
    func onDiscovery(peripheral: CBPeripheral)
    func onConnect(peripheral: CBPeripheral)
    func onDisconnect(peripheral: CBPeripheral)
}

class ScanManager: NSObject, Scanable {
    weak var delegate: ScanableDelegate?

    private var centralManager: CBCentralManager!

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
    }

    func scan(for services: [CBUUID]) {
        centralManager.scanForPeripherals(withServices: services)
    }

    func connect(to peripheral: CBPeripheral) {
        centralManager.stopScan()
        centralManager.connect(peripheral)
    }

    func disconnect(from peripheral: CBPeripheral) {
        centralManager.cancelPeripheralConnection(peripheral)
    }
}

extension ScanManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            delegate?.didBecomeReady()
        }
    }

    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String: Any],
        rssi RSSI: NSNumber
    ) {
        delegate?.onDiscovery(peripheral: peripheral)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        delegate?.onConnect(peripheral: peripheral)
    }

    func centralManager(
        _ central: CBCentralManager,
        didDisconnectPeripheral peripheral: CBPeripheral,
        error: (any Error)?
    ) {
        delegate?.onDisconnect(peripheral: peripheral)
    }
}
