//
//  PasswordTextField.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.10.24.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var password: String

    var body: some View {
        TitledView(title: "Password") {
            SecureField("Enter password", text: $password)
                .controlSize(.extraLarge)
        }
    }
}

#Preview {
    let password: Binding<String> = .constant("")
    PasswordTextField(password: password)
}
