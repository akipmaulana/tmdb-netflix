//
//  DiscoveryKind.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

enum DiscoveryKind {
    case movie
    case tv
}

protocol ThematicProtocol {
    var name: String { get }
}

enum MovieThematicKind: ThematicProtocol {
    
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var name: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    static let all: [MovieThematicKind] = [.nowPlaying, .popular, .topRated, .upcoming]
}

enum TVThematicKind: ThematicProtocol {
    case airingToday
    case onTheAir
    case popular
    case topRated
    
    var name: String {
        switch self {
        case .airingToday:
            return "TV Airing Today"
        case .onTheAir:
            return "TV On The Air"
        case .popular:
            return "TV Popular"
        case .topRated:
            return "TV Top Rated"
        }
    }
    
    static let all: [TVThematicKind] = [.airingToday, .onTheAir, .popular, .topRated]
}
