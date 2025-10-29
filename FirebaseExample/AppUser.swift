//
//  AppUser.swift
//  FirebaseExample
//
//  Created by Negar Pirasteh on 2025-10-28.
//

import Foundation
import FirebaseFirestore

struct AppUser: Codable, Identifiable {
    var id: String?
    var email: String
    var displayName: String
    var isActive: Bool = true
}
