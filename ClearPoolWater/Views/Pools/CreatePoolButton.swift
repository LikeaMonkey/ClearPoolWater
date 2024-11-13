//
//  CreatePoolButton.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct CreatePoolButton: View {
    let onCreatePoolDisappear: (() -> Void)?

    @State private var isCreatePoolPresented = false

    var body: some View {
        Button {
            isCreatePoolPresented.toggle()
        } label: {
            Image(systemName: "plus")
        }
        .sheet(isPresented: $isCreatePoolPresented) {
            NavigationStack {
                CreatePoolView()
                    .presentationDetents([.medium])
                    .onDisappear {
                        onCreatePoolDisappear?()
                    }
            }
        }
    }
}

#Preview {
    CreatePoolButton {}
}
