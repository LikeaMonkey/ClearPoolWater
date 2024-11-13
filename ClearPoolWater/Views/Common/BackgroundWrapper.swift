//
//  BackgroundWrapper.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.11.24.
//

import SwiftUI

struct BackgroundWrapper<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        ZStack {
            BackgroundView()
            content()
        }
    }
}
