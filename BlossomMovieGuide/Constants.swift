//
//  Constants.swift
//  BlossomMovieGuide
//
//  Created by Kelly Lampotang on 7/29/26.
//

import Foundation
import SwiftUI

struct Constants {
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let downloadString = "Download"
    static let searchString = "Search"
    static let trendingMovieString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMovieString = "Top Rated Movie"
    static let topRatedTVString = "Top Rated TV"
    
    static let movieFetchString = "movie"
    
    static let playString = "Play"
    
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    
    static let testTitleURL = "https://image.tmdb.org/t/p/w500/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"
    static let testTitleURL2 = "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"
    static let testTitleURL3 = "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
    
    static let posterURLStart = "https://image.tmdb.org/t/p/w500"

    static func addPosterPath(to titles: inout[Title]) {
        for index in titles.indices {
            if let path = titles[index].posterPath {
                titles[index].posterPath = Constants.posterURLStart + path
            }
        }
    }
}
