//
//  UserProfile.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftData
import Foundation

@Model
final class UserProfileModel {

    var fullName: String
    var username: String
    var email: String
    var phone: String
    /// Stores the avatar as raw PNG/JPEG data so it persists locally
    var avatarData: Data?

    init(
        fullName: String = "",
        username: String = "",
        email: String = "",
        phone: String = "",
        avatarData: Data? = nil
    ) {
        self.fullName   = fullName
        self.username   = username
        self.email      = email
        self.phone      = phone
        self.avatarData = avatarData
    }
}
