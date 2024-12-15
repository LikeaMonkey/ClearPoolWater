//
//  CustomListStyle.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.12.24.
//

import SwiftUI

struct CustomListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(.insetGrouped)
            .listSectionSpacing(20)
            .contentMargins(.top, 12)
    }
}

extension View {
    func customListStyle() -> some View {
        modifier(CustomListStyle())
    }
}
