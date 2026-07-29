//
//  Errors.swift
//  BlossomMovieGuide
//
//  Created by Kelly Lampotang on 7/29/26.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingError(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "API configuration file not found"
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load API configuration data: \(error.localizedDescription)"
        case .decodingError(underlyingError: let error):
            return "Failed to decode API configuration: \(error.localizedDescription)"
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingERror: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlyingERror: let error):
            return "Bad URL response: \(error.localizedDescription)"
        case .missingConfig:
            return "API configuration is missing"
        case .urlBuildFailed:
            return "Failed to build URL"
        }
    }
}
