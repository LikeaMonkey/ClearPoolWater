//
//  CardStyle.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.12.24.
//

import SwiftUI

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.regularMaterial)
            .cornerRadius(Constants.cornerRadius)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}
