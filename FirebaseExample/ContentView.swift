//
//  ContentView.swift
//  FirebaseExample
//
//  Created by Negar Pirasteh on 2025-10-21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var showLogin = false
    @State private var showRegister = false

    var body: some View {
        VStack(spacing: 16) {
            if let email = authManager.user?.email {
                Text("Welcome, \(email)")
                Button("Sign Out") { authManager.signOut() }
                    .buttonStyle(.bordered)
            } else {
                Text("Firebase Example").font(.title2).bold()
                Button("Login") { showLogin = true }
                    .buttonStyle(.borderedProminent)
                Button("Register") { showRegister = true }
                    .buttonStyle(.bordered)
            }
        }
        .padding()
        .sheet(isPresented: $showLogin) {
            LoginView()
                .environmentObject(authManager)
                .onChange(of: authManager.user, initial: false) { _, newUser in
                    if newUser != nil { showLogin = false }
                }

        }
        .sheet(isPresented: $showRegister) {
            RegisterView()
                .environmentObject(authManager)
                .onChange(of: authManager.user, initial: false) { _, newUser in
                    if newUser != nil { showRegister = false }
                }

        }
    }
}




#Preview {
    ContentView()
        .environmentObject(AuthManager())
}

