//
//  Endpoints.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation

// MARK: - API Endpoints

enum Endpoints {
    static let baseURL = "https://api.olgrey.com/v1"

    // Auth
    static let login    = "\(baseURL)/auth/login"
    static let signup   = "\(baseURL)/auth/signup"
    static let logout   = "\(baseURL)/auth/logout"

    // User
    static let profile  = "\(baseURL)/user/profile"

    // Home
    static let home     = "\(baseURL)/home"
}
