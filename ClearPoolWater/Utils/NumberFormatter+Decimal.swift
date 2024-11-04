//
//  DecimalFormatter.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import Foundation

extension NumberFormatter {
    static func decimal(
        locale: Locale = Locale.current,
        maximumFractionDigits: Int = 2
    ) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
