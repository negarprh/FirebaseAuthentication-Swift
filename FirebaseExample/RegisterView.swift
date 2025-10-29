//
//  RegisterView.swift
//  FirebaseExample
//
//  Created by Negar Pirasteh on 2025-10-23.
//
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var email = ""
    @State private var password = ""
    @State private var confirm = ""
    @State private var displayName = ""
    @State private var localError = ""

    var body: some View {
        VStack(spacing: 12) {
            Text("Register").font(.title2).bold()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .textFieldStyle(.roundedBorder)

            TextField("Display Name", text: $displayName)
                .textFieldStyle(.roundedBorder)

            SecureField("Password (min 6)", text: $password)
                .textFieldStyle(.roundedBorder)

            SecureField("Confirm password", text: $confirm)
                .textFieldStyle(.roundedBorder)

            Button("Create Account") {
                localError = ""
                if let msg = validateForm() { localError = msg; return }
                authManager.errorMessage = ""
                authManager.signUp(email: email, password: password, displayName: displayName)
            }
            .buttonStyle(.borderedProminent)

            
            if !localError.isEmpty {
                Text(localError).foregroundColor(.red).font(.footnote)
            } else if !authManager.errorMessage.isEmpty {
                Text(authManager.errorMessage).foregroundColor(.red).font(.footnote)
            }
            Spacer()
        }
        .padding()
    }

    private func validateForm() -> String? {
        let trimmedName = displayName.trimmingCharacters(in: .whitespaces)
        if email.isEmpty { return "Email is required." }
        if !email.contains("@") || !email.contains(".") { return "Enter a valid email address." }
        if trimmedName.isEmpty { return "Display name is required." }
        if password.count < 6 { return "Password must be at least 6 characters." }
        if password != confirm { return "Passwords do not match." }
        return nil
    }
}
