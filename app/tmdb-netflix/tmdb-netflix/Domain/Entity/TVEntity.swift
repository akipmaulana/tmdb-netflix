//
//  TVEntity.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import Foundation

struct TVSeries: Content {
    var title: String?
    var overview: String?
    var genreIds: [Int]?
    var voteAverage: Double?
    var voteCount: Int?
    var id: Int?
    let backdropPath: String?
    let firstAirDate: String?
    let name: String?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName: String?
    let popularity: Double?
    let posterPath: String?
}
