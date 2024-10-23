//
//  ConfirmPasswordTextField.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.10.24.
//

import SwiftUI

struct ConfirmPasswordTextField: View {
    @Binding var password: String

    var body: some View {
        TitledView(title: "Confirm Password") {
            SecureField("Enter password again", text: $password)
                .controlSize(.extraLarge)
        }
    }
}

#Preview {
    let password: Binding<String> = .constant("")
    ConfirmPasswordTextField(password: password)
}
