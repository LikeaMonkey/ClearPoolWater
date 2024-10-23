//
//  UpdateWaterStatusButton.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct UpdateWaterStatusButton: View {
    let poolID: Int
    let onUpdateWaterStatusDisappear: (() -> Void)?

    @State private var isWaterStatusSheetPresented = false

    var body: some View {
        Button {
            isWaterStatusSheetPresented.toggle()
        } label: {
            Text("Update water status")
                .frame(maxWidth: .infinity)
        }
        .controlSize(.large)
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $isWaterStatusSheetPresented) {
            NavigationView {
                UpdateWaterStatusView(poolID: poolID)
            }
            .presentationDetents([.medium])
            .onDisappear {
                onUpdateWaterStatusDisappear?()
            }
        }
    }
}

#Preview {
    UpdateWaterStatusButton(poolID: 1) {}
}
