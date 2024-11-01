//
//  Double+.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

extension Double {
    func isNearlyEqual(to other: Double, tolerance: Double = 1e-10) -> Bool {
        abs(self - other) < tolerance
    }
}
