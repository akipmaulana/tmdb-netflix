//
//  MovieEntity.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import Foundation

struct Movie: Content {
    var title: String?
    var overview: String?
    var genreIds: [Int]?
    var voteAverage: Double?
    var voteCount: Int?
    var id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    let video: Bool?
    let status: String?
    
    var isAdult: Bool {
        return adult ?? false
    }
}
