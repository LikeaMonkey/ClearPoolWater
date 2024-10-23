//
//  DecimalFormatter.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import Foundation

class DecimalFormatter {
    private let formatter: NumberFormatter

    init(locale: Locale = Locale.current) {
        formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
    }

    func double(from string: String) -> Double? {
        formatter.number(from: string)?.doubleValue
    }
}
