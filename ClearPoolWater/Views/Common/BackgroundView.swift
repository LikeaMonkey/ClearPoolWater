//
//  BackgroundView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 4.11.24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [.poolTopColor, .poolMiddleColor, .poolBottomColor]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

extension Color {
    static let poolTopColor = Color(red: 31 / 255, green: 175 / 255, blue: 255 / 255)
    static let poolMiddleColor = Color(red: 18 / 255, green: 216 / 255, blue: 250 / 255)
    static let poolBottomColor = Color(red: 166 / 255, green: 255 / 255, blue: 203 / 255)
}
