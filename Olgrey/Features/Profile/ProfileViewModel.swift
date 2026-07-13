//
//  ProfileViewModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI
import SwiftData

@Observable
final class ProfileViewModel {

    var profile: UserProfile
    var showEditSheet: Bool = false
    var showChangePassword: Bool = false

    init(profile: UserProfile) {
        self.profile = profile
    }

    /// Saves avatar image data onto the model (SwiftData persists automatically)
    func updateAvatar(_ data: Data) {
        profile.avatarData = data
    }

    var avatarImage: UIImage? {
        guard let data = profile.avatarData else { return nil }
        return UIImage(data: data)
    }
}
