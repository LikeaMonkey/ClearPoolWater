//
//  WaterStatus.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import Foundation

struct WaterStatus: Codable, Identifiable {
    var id: Int

    var ph: Double
    var chlorine: Double
    var alkalinity: Double?
    var temperature: Double?
}

extension WaterStatus {
    struct Create: Codable {
        var ph: Double
        var chlorine: Double
        var alkalinity: Double?
        var temperature: Double?
        var pool: Int
    }
}
