//
//  UUIDs.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 8.12.24.
//

@preconcurrency import CoreBluetooth

enum UUIDs {
    static let sensorService = CBUUID(string: "d888a9c2-f3cc-11ed-a05b-0242ac120003")
    static let phCharacteristic = CBUUID(string: "d888a9c3-f3cc-11ed-a05b-0242ac120003")
}
