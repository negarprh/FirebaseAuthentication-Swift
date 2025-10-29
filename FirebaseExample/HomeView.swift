//
//  HomeView.swift
//  FirebaseExample
//
//  Created by Negar Pirasteh on 2025-10-23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var newName = ""

    var body: some View {
        VStack(spacing: 14) {
            Text("Profile").font(.title2).bold()
            Text("Email: \(authManager.appUser?.email ?? authManager.user?.email ?? "N/A")")
            Text("Display: \(authManager.appUser?.displayName ?? authManager.user?.displayName ?? "N/A")")

            TextField("Update display name", text: $newName)
                .textFieldStyle(.roundedBorder)

            Button("Save Name") {
                authManager.updateProfile(displayName: newName)
                newName = ""
            }
            .disabled(newName.trimmingCharacters(in: .whitespaces).isEmpty)

            Divider()
            Button("Sign Out") { authManager.signOut() }.buttonStyle(.bordered)
        }
        .padding()
        .onAppear { authManager.fetchCurrentAppUser() }
    }
}
