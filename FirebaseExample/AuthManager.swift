//
//  AuthManager.swift
//  FirebaseExample
//
//  Created by Negar Pirasteh on 2025-10-23.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore


final class AuthManager: ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var appUser: AppUser?
    @Published var errorMessage = ""

    private let db = Firestore.firestore()

    init() {
        
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.user = user
            if let uid = user?.uid {
                self?.loadAppUser(uid: uid)
            } else {
                self?.appUser = nil
            }
        }
    }

   
    func signUp(email: String, password: String, displayName: String) {
        errorMessage = ""
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] res, err in
            guard let self else { return }
            if let err = err { self.errorMessage = err.localizedDescription; return }
            guard let u = res?.user else { return }

            
            let change = u.createProfileChangeRequest()
            change.displayName = displayName
            change.commitChanges(completion: nil)

           
            let doc = AppUser(id: u.uid, email: email, displayName: displayName, isActive: true)
            do {
                try self.db.collection("users").document(u.uid).setData(from: doc)
                self.appUser = doc
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    
    func login(email: String, password: String) {
        guard isValidEmail(email), password.count >= 6 else {
            errorMessage = "Invalid email or password"; return
        }
        errorMessage = ""
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, err in
            if let err = err { self?.errorMessage = err.localizedDescription }
        }
    }

    
    func fetchCurrentAppUser() {
        guard let uid = user?.uid else { return }
        loadAppUser(uid: uid)
    }

    
    func updateProfile(displayName: String) {
        guard let u = user else { return }
        let trimmed = displayName.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { errorMessage = "Display name required"; return }

        let change = u.createProfileChangeRequest()
        change.displayName = trimmed
        change.commitChanges(completion: nil)

       
        db.collection("users").document(u.uid).updateData(["displayName": trimmed]) { [weak self] err in
            if let err = err { self?.errorMessage = err.localizedDescription; return }
            self?.appUser?.displayName = trimmed
        }
    }

  
    func signOut() {
        errorMessage = ""
        do { try Auth.auth().signOut() } catch { errorMessage = error.localizedDescription }
    }

  
    private func loadAppUser(uid: String) {
        db.collection("users").document(uid).getDocument { [weak self] snap, err in
            if let err = err { self?.errorMessage = err.localizedDescription; return }
            self?.appUser = try? snap?.data(as: AppUser.self)
        }
    }

    private func isValidEmail(_ s: String) -> Bool { s.contains("@") && s.contains(".") }
}
