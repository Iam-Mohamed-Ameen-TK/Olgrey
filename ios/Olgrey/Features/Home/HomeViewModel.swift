//
//  HomeViewModel.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var isLoading: Bool = false

    func loadData() {
        isLoading = true
        Task {
            defer { isLoading = false }
            // TODO: Fetch home data from API
        }
    }
}
