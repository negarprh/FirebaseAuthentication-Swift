# 🔥 Firebase Authentication - SwiftUI Starter

A clean, modern SwiftUI app that integrates **Firebase Authentication** and **Cloud Firestore** — built as the foundation for future full-stack iOS apps.

This project is intentionally minimal. It focuses on doing one thing well:  
**securely registering, logging in, and managing users via Firebase**, while syncing profile data with Firestore.  

---

## ✨ Highlights

- 🔐 **Email / Password Authentication**
- ☁️ **Cloud Firestore** integration (`/users/{uid}`)
- 🪄 **Automatic profile sync** between Auth & Firestore
- 🧠 **Modular SwiftUI architecture** (easy to extend)
- ✅ **Client-side validation** (email, password, display name)
- 🚪 **Sign-out and live user state updates**

---

## 🧱 Tech Stack

| Layer | Technology |
|-------|-------------|
| Frontend | SwiftUI (iOS 17+) |
| Backend | Firebase Authentication |
| Database | Cloud Firestore |
| Package Manager | Swift Package Manager (SPM) |
| Language | Swift 5.9 |

---

## 🗂 Project Structure

```

FirebaseExample/
├── FirebaseExampleApp.swift   // Initializes Firebase + environment
├── AuthManager.swift          // Handles Auth + Firestore operations
├── AppUser.swift              // Firestore data model
├── ContentView.swift          // Routes between Auth / Home screens
├── RegisterView.swift         // Registration UI + validation
├── LoginView.swift            // Login UI
├── HomeView.swift             // Profile + update name + sign out
└── GoogleService-Info.plist   // (excluded) Firebase config

````

---

## 🚀 Setup

### 1. Firebase Console
1. Go to [Firebase Console](https://console.firebase.google.com/).
2. Create a new project (e.g. **FirebaseExample**).
3. Add an iOS app → use your **Bundle ID** from Xcode.
4. Download `GoogleService-Info.plist` → drag into your Xcode target.

### 2. Enable Services
**Authentication**
- Go to *Authentication → Sign-in method* → Enable **Email/Password**.

**Firestore**
- Go to *Firestore Database → Create database* → Start in **test mode** (for local dev).

### 3. Add Dependencies
In Xcode:  
**File → Add Packages →**  
`https://github.com/firebase/firebase-ios-sdk`

Select and add:
- `FirebaseAuth`
- `FirebaseFirestore`
- `FirebaseCore`


---

This project is for learning how to implement Firebase Authentication while saving users in Firstre database.
