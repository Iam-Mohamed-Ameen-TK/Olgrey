//
//  OlgreyApp.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI
import SwiftData

@main
struct OlgreyApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: UserProfileModel.self)
    }
}
