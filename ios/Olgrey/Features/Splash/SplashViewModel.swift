//
//  SplashViewModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation
import Combine

@MainActor
class SplashViewModel: ObservableObject {
    @Published var isReady: Bool = false

    func start() {
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000) // 2s splash delay
            isReady = true
        }
    }
}
