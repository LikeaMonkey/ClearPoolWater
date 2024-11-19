//
//  FancyBackground.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 19.11.24.
//

import SwiftUI

struct FancyBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            BackgroundView()
            content
        }
    }
}

extension View {
    func fancyBackground() -> some View {
        modifier(FancyBackground())
    }
}
