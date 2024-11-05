//
//  TermsAndConditionsButton.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct TermsAndConditionsButton: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isPresented = false

    var body: some View {
        Button("Terms & Conditions") {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                // TODO: Add Terms and Conditions Text
                Text("TBD")
                    .presentationDetents([.large])
                    .toolbar {
                        ToolbarItem {
                            Button("Done") {
                                dismiss()
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    TermsAndConditionsButton()
}
