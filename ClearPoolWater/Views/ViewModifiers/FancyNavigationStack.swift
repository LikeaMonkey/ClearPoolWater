//
//  FancyNavigationStack.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 19.11.24.
//

import SwiftUI

struct FancyNavigationStack: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        NavigationStack {
            content
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
        .toolbarBackground(backgroundColor, for: .tabBar)
    }

    private var backgroundColor: Color {
        colorScheme == .dark ? .backgroundBottomDark : .backgroundBottom
    }
}

extension View {
    func fancyNavigationStack() -> some View {
        modifier(FancyNavigationStack())
    }
}
