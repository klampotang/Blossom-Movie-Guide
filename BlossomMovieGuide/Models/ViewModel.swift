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
    
    func getTitles() async {
        homeStatus = .fetching
        do {
            trendingMovies = try await dataFetcher.fetchTitles(for: Constants.movieFetchString, by: "trending")
            trendingTV = try await dataFetcher.fetchTitles(for: Constants.tvFetchString, by: Constants.trendingFetchString)
            topRatedMovies = try await dataFetcher.fetchTitles(for: Constants.movieFetchString, by: "top_rated")
            topRatedTV = try await dataFetcher.fetchTitles(for: Constants.tvFetchString, by: Constants.topRatedFetchString)
            homeStatus = .success
        } catch {
            print(error)
            homeStatus = .failed(underlyingError: error)
        }
    }
}
