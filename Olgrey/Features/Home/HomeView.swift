//
//  HomeView.swift
//  Olgrey
//
//  Created by Mohamed Ameen on 01/07/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Hello 👋")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.horizontal)

                            // TODO: Add home content here
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}
