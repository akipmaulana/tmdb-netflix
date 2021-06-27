//
//  GenreEntity.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]?
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}

protocol Content: Codable {
    var id: Int? { set get }
    var title: String? { set get }
    var overview: String? { set get }
    var genreIds: [Int]? { set get }
    var voteAverage: Double? { set get }
    var voteCount: Int? { set get }
    var posterPath: String? { set get }
    var releaseDate: String? { get set }
    var isAdult: Bool { get }
}

extension Content {
    var released: Bool {
        return !(releaseDate?.isEmpty ?? true)
    }
}
