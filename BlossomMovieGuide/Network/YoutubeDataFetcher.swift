//
//  YoutubeDataFetcher.swift
//  BlossomMovieGuide
//
//  Created by Kelly Lampotang on 7/29/26.
//

import Foundation

struct YoutubeDataFetcher {
    let youtubeAPIKey = APIConfig.shared?.youtubeAPIKey
    let youtubeSearchURL = APIConfig.shared?.youtubeSearchURL
    
    func fetchVideoId(for title: String) async throws -> String {
        guard let baseSearchUrl = youtubeSearchURL else {
            throw NetworkError.missingConfig
        }
        guard let searchAPIKey = youtubeAPIKey else {
            throw NetworkError.missingConfig
        }
        let trailerSearch = title + YoutubeURLStrings.space.rawValue + YoutubeURLStrings.trailer.rawValue
        
        guard let fetchVideoURL = URL(string: baseSearchUrl)?.appending(queryItems: [
            URLQueryItem(name: YoutubeURLStrings.queryShorten.rawValue, value: trailerSearch),
            URLQueryItem(name: YoutubeURLStrings.key.rawValue, value: searchAPIKey)
        ]) else {
            throw NetworkError.urlBuildFailed
        }
        print(fetchVideoURL)
        
        return try await fetchAndDecode(url: fetchVideoURL, type: YoutubeSearchResponse.self).items?.first?.id?.videoId ?? ""
    }
}
