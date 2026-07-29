//
//  UpcomingView.swift
//  BlossomMovieGuide
//
//  Created by Kelly Lampotang on 7/29/26.
//

import SwiftUI

struct UpcomingView: View {
    let viewModel = ViewModel()
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(titles: viewModel.upcomingMovies)
                case .failed(let underlyingError):
                    Text(underlyingError.localizedDescription)
                }
            }
            .task {
                await viewModel.getUpcomingMovies()
            }
        }
    }
}

#Preview {
    UpcomingView()
}
