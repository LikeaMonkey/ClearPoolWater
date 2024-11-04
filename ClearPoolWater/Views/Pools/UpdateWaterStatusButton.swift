//
//  UpdateWaterStatusButton.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct UpdateWaterStatusButton: View {
    let poolId: Int
    let waterStatusId: Int?
    let onUpdateWaterStatusDisappear: (() -> Void)?

    @State private var isWaterStatusSheetPresented = false

    var body: some View {
        Button("Update") {
            isWaterStatusSheetPresented.toggle()
        }
        .disabled(waterStatusId == nil)
        .buttonStyle(.bordered)
        .sheet(isPresented: $isWaterStatusSheetPresented) {
            NavigationView {
                UpdateWaterStatusView(poolId: poolId, waterStatusId: waterStatusId!)
            }
            .presentationDetents([.medium])
            .onDisappear {
                onUpdateWaterStatusDisappear?()
            }
        }
    }
}

#Preview {
    UpdateWaterStatusButton(poolId: 1, waterStatusId: 1) {}
}
