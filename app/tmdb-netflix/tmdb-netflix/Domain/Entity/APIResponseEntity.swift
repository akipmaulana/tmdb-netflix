//
//  APIResponseEntity.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import Foundation

struct ResponsePageable<C: Codable>: Codable {
    let page: Int?
    let results: [C]?
    let totalPages: Int?
    let totalResults: Int?
}
