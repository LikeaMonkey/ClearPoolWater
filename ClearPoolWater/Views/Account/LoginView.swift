//
//  LoginView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import AuthenticationServices
import SwiftUI

struct LoginView: View {
    @State private var loginViewModel = LoginViewModel()
    @State private var isSignUpPresented = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Sign in")
                .font(.largeTitle)
            Text("Please enter your details.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom, 30)

            SignInWithAppleButton { request in
                request.requestedScopes = [.email]
            } onCompletion: { result in
                loginViewModel.handleSignInWithApple(result)
            }
            .frame(height: 56)

            Text("or")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)

            EmailTextField(email: $loginViewModel.email)
            PasswordTextField(password: $loginViewModel.password)

            Button {
                Task {
                    await loginViewModel.login()
                }
            } label: {
                if loginViewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Login")
                        .font(.title2)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                }
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .disabled(loginViewModel.isLoading)

            Divider()

            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.secondary)
                Button {
                    isSignUpPresented = true
                } label: {
                    Text("Sign Up")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .textFieldStyle(.roundedBorder)
        .padding(40)
        .sheet(isPresented: $isSignUpPresented) {
            RegisterView()
                .presentationDetents([.large])
        }
    }
}

#Preview {
    LoginView()
}
