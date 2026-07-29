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
    
    func fetchTitles(for media: String, by type: String) async throws -> [Title] {
        let fetchTitleUrl = try buildURL(media: media, type: type)
        guard let fetchTitleUrl = fetchTitleUrl else {
            throw NetworkError.urlBuildFailed
        }
        
        let (data, urlResponse) = try await URLSession.shared.data(from: fetchTitleUrl)
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            let error = NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]
            )
            throw NetworkError.badURLResponse(underlyingERror: error)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles = try decoder.decode(APIObject.self, from: data).results

        // Update to add poster paths
        Constants.addPosterPath(to: &titles)
        return titles
    }
    
    private func buildURL(media: String, type: String) throws -> URL? {
        guard let baseUrl = tmdbBaseURL else {
            throw NetworkError.missingConfig
        }
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }
        
        var path: String
        
        if type == "trending" {
            path = "3/trending/\(media)/day"
        } else if type == "top_rated" {
            path = "3/\(media)/top_rated"
        } else {
            throw NetworkError.urlBuildFailed
        }
        
        guard let url = URL(string: baseUrl)?
            .appending(path: path)
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ])else {
            throw NetworkError.urlBuildFailed
        }
        
        return url
    }
}
