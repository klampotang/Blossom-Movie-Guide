//
//  NetworkHelper.swift
//  BlossomMovieGuide
//
//  Created by Kelly Lampotang on 7/29/26.
//

import Foundation

func fetchAndDecode<T: Decodable>(url: URL, type: T.Type) async throws -> T {
    let (data, urlResponse) = try await URLSession.shared.data(from: url)
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
    return try decoder.decode(type, from: data)
}
