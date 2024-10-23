//
//  PoolStatus.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import Foundation

struct PoolStatus: Codable, Identifiable {
    var id: Int

    var skimDate: Date?
    var vacuumDate: Date?
    var brushDate: Date?
    var emptyBasketsDate: Date?
    var testWaterDate: Date?
    var cleanFilterDate: Date?
    var runPumpDate: Date?
    var inspectDate: Date?
}

extension PoolStatus {
    struct Create: Codable {
        var skim: Bool
        var vacuum: Bool
        var brush: Bool
        var emptyBaskets: Bool
        var testWater: Bool
        var cleanFilter: Bool
        var runPump: Bool
        var inspect: Bool
        var pool: Int
    }
}
