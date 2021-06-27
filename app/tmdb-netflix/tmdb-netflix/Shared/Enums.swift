//
//  Enums.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import UIKit

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

// MARK: - View Enum(s)
enum GradientOrientation {
    case horizontal
    case vertical
    case diagonal
    
    var startPoint: CGPoint {
        return points.startPoint
    }
    
    var endPoint: CGPoint {
        return points.endPoint
    }
    
    var points: GradientPoints {
        switch self {
        case .horizontal:
            return (CGPoint.init(x: 0.0, y: 0.5), CGPoint.init(x: 1.0, y: 0.5))
        case .vertical:
            return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 0.0, y: 1.0))
        case .diagonal:
            return (CGPoint.init(x: 0.0, y: 0.0), CGPoint.init(x: 1.0, y: 1.0))
        }
    }
}
