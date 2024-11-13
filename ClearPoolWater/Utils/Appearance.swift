//
//  Appearance.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import SwiftUI

enum Appearance: String, CaseIterable, Identifiable {
    case system, light, dark

    var id: String { rawValue }

    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
