//
//  UpdateWaterStatusButton.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct UpdateWaterStatusButton: View {
    let poolId: Int
    let onUpdateWaterStatusDisappear: (() -> Void)?

    @State private var isWaterStatusSheetPresented = false

    var body: some View {
        Button {
            isWaterStatusSheetPresented.toggle()
        } label: {
            Text("Update")
        }
        .buttonStyle(.bordered)
        .sheet(isPresented: $isWaterStatusSheetPresented) {
            NavigationView {
                UpdateWaterStatusView(poolId: poolId)
            }
            .presentationDetents([.medium])
            .onDisappear {
                onUpdateWaterStatusDisappear?()
            }
        }
    }
}

#Preview {
    UpdateWaterStatusButton(poolId: 1) {}
}
