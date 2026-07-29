//
//  DataFetcher.swift
//  BlossomMovieGuide
//
//  Created by Kelly Lampotang on 7/29/26.
//

import Foundation

let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey

func fetchTitles(for media: String) async throws -> [Title] {
    guard let baseUrl = tmdbBaseURL else {
        throw NetworkError.missingConfig
    }
    guard let apiKey = tmdbAPIKey else {
        throw NetworkError.missingConfig
    }
    
    guard let fetchTitleUrl = URL(string: baseUrl)?
        .appending(path: "3/trending/\(media)/day")
        .appending(queryItems: [
            URLQueryItem(name: "api_key", value: apiKey)
        ])else {
        throw NetworkError.urlBuildFailed
    }
    
    print(fetchTitleUrl)
    
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
    return try decoder.decode(APIObject.self, from: data).results
}
