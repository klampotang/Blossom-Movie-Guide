//
//  ViewModel.swift
//  BlossomMovieGuide
//
//  Created by Kelly Lampotang on 7/29/26.
//

import Foundation

@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []
    
    var heroTitle = Title.previewTitles[0]
    
    func getTitles() async {
        homeStatus = .fetching
        if trendingMovies.isEmpty {
            do {
                async let tMovies = dataFetcher.fetchTitles(for: Constants.movieFetchString, by: "trending")
                async let tTV =  dataFetcher.fetchTitles(for: Constants.tvFetchString, by: Constants.trendingFetchString)
                async let trMovies = dataFetcher.fetchTitles(for: Constants.movieFetchString, by: "top_rated")
                async let trTV = dataFetcher.fetchTitles(for: Constants.tvFetchString, by: Constants.topRatedFetchString)
                
                trendingMovies = try await tMovies
                trendingTV = try await tTV
                topRatedMovies = try await trMovies
                topRatedTV = try await trTV
                
                if let title = trendingMovies.randomElement() {
                    heroTitle = title
                }

                homeStatus = .success
            } catch {
                print(error)
                homeStatus = .failed(underlyingError: error)
            }
        } else {
            homeStatus = .success
        }
    }
}
