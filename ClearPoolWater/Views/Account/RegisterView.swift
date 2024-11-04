//
//  RegisterView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import SwiftUI

struct RegisterView: View {
    @State private var registerViewModel = RegisterViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Sign Up")
                .font(.largeTitle)
            Text("Please enter your details.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom, 30)

            if registerViewModel.success {
                Image(systemName: "checkmark.circle.fill")
                    .frame(width: 40, height: 40)
                Text("You have successfully registered!")
                Spacer()
            } else {
                if registerViewModel.isLoading {
                    ProgressView()
                }

                EmailTextField(email: $registerViewModel.email)
                PasswordTextField(password: $registerViewModel.password)
                ConfirmPasswordTextField(password: $registerViewModel.password)

                Button {
                    Task {
                        await registerViewModel.register()
                    }
                } label: {
                    Text("Sign Up")
                        .font(.title2)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                }
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .padding(.top, 60)
                .disabled(registerViewModel.isLoading)
            }
        }
        .textFieldStyle(.roundedBorder)
        .padding(40)
    }
}

#Preview {
    RegisterView()
}
