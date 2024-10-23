//
//  UpdatePoolStatusButton.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import SwiftUI

struct UpdatePoolStatusButton: View {
    let poolID: Int
    let onUpdatePoolStatusDisappear: (() -> Void)?

    @State private var isPoolStatusSheetPresented = false

    var body: some View {
        Button {
            isPoolStatusSheetPresented.toggle()
        } label: {
            Text("Update pool status")
                .frame(maxWidth: .infinity)
        }
        .controlSize(.large)
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $isPoolStatusSheetPresented) {
            NavigationView {
                UpdatePoolStatusView(poolID: poolID)
            }
            //            .presentationDetents([.medium])
            .onDisappear {
                onUpdatePoolStatusDisappear?()
            }
        }
    }
}

#Preview {
    UpdatePoolStatusButton(poolID: 1) {}
}
