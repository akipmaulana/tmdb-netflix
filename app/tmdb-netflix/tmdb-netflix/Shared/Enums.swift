//
//  Enums.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import Foundation

// MARK: - API Enum(s)
enum ApiError: Error {
    case invalidToken(message: String)
    case apiServer(code: Int, message: String)
    
    var error: NSError{
        switch self {
        case .invalidToken(let message):
            return NSError(domain: Bundle.main.bundleIdentifier!, code: 404, userInfo: [NSLocalizedDescriptionKey: message])
        case .apiServer(let code, let message):
            return NSError(domain: Bundle.main.bundleIdentifier!, code: code, userInfo: [NSLocalizedDescriptionKey: message])
        }
    }
}

enum ApiVersion: String {
    case v3 = "3"
    case v4 = "4"
}
