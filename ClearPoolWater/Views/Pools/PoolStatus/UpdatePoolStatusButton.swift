//
//  UpdatePoolStatusButton.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import SwiftUI

struct UpdatePoolStatusButton: View {
    let poolId: Int
    let onUpdatePoolStatusDisappear: (() -> Void)?

    @State private var isPoolStatusSheetPresented = false

    var body: some View {
        Button("Update") {
            isPoolStatusSheetPresented.toggle()
        }
        .buttonStyle(.bordered)
        .sheet(isPresented: $isPoolStatusSheetPresented) {
            NavigationView {
                UpdatePoolStatusView(poolId: poolId)
            }
            .onDisappear {
                onUpdatePoolStatusDisappear?()
            }
        }
    }
}

#Preview {
    UpdatePoolStatusButton(poolId: 1) {}
}
