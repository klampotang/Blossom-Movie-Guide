//
//  DataFetcher.swift
//  BlossomMovieGuide
//
//  Created by Kelly Lampotang on 7/29/26.
//

import Foundation

struct DataFetcher {
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    
    func fetchTitles(for media: String, by type: String, with searchTitle: String? = nil) async throws -> [Title] {
        let fetchTitleUrl = try buildURL(media: media, type: type, searchPhrase: searchTitle)
        guard let fetchTitleUrl = fetchTitleUrl else {
            throw NetworkError.urlBuildFailed
        }
        
        var titles = try await fetchAndDecode(url: fetchTitleUrl, type: TMDBAPIObject.self).results

        // Update to add poster paths
        Constants.addPosterPath(to: &titles)
        return titles
    }
    
    /// MARK - Private
    
    private func buildURL(media: String, type: String, searchPhrase: String? = nil) throws -> URL? {
        guard let baseUrl = tmdbBaseURL else {
            throw NetworkError.missingConfig
        }
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }
        
        var path: String
        
        if type == "trending" {
            path = "3/\(type)/\(media)/day"
        } else if type == "top_rated" || type == "upcoming" {
            path = "3/\(media)/\(type)"
        } else if type == "search" {
            path = "3/\(type)/\(media)"
        } else {
            throw NetworkError.urlBuildFailed
        }
        
        var urlQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        if let searchPhrase {
            urlQueryItems.append(URLQueryItem(name: "query", value: searchPhrase))
        }
        
        guard let url = URL(string: baseUrl)?
            .appending(path: path)
            .appending(queryItems: urlQueryItems)else {
            throw NetworkError.urlBuildFailed
        }
        
        return url
    }
}
