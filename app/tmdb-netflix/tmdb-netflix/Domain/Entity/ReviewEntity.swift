//
//  ReviewEntity.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

struct AuthorReview: Codable {
    let name: String?
    let username: String?
    let avatarPath: String?
    let rating: Double?
}

struct Review {
    let author: String?
    let authorDetail: AuthorReview?
    let content: String?
    let createdAt: String?
    let updatedAt: String?
    let id: String?
    let url: String?
}
