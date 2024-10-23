//
//  EmailTextField.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.10.24.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var email: String

    var body: some View {
        TitledView(title: "Email") {
            TextField("Enter email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .controlSize(.extraLarge)
        }
    }
}

#Preview {
    let email: Binding<String> = .constant("")
    EmailTextField(email: email)
}
