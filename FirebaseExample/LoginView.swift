//
//  LoginView.swift
//  FirebaseExample
//
//  Created by Negar Pirasteh on 2025-10-23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 12) {
            Text("Login").font(.title2).bold()
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password).textFieldStyle(.roundedBorder)
            Button("Sign In") { authManager.login(email: email, password: password) }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty || password.count < 6)
            if !authManager.errorMessage.isEmpty {
                Text(authManager.errorMessage).foregroundColor(.red).font(.footnote)
            }
            Spacer()
        }
        .padding()
    }
}
