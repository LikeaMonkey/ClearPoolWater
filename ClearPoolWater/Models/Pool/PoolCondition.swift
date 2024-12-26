//
//  PoolCondition.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 26.12.24.
//
import SwiftUI

enum PoolCondition: String {
    case good, okay, bad, unknown

    var text: String { rawValue.capitalized }

    var color: Color {
        switch self {
        case .good: .green
        case .okay: .yellow
        case .bad: .red
        case .unknown: .gray
        }
    }
}
