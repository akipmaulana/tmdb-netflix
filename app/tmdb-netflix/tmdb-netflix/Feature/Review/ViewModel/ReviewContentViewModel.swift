//
//  ReviewContentViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

protocol ReviewContenViewModel: TMDBViewModel {
    init(content: Content?)
    
    var contentRatingLabelText: String? { get }
    var contentVotingLabelText: String? { get }
}

final class ReviewContentDefaultViewModel: ReviewContenViewModel {
    
    private let content: Content?
    
    init(content: Content?) {
        self.content = content
    }
    
    var contentRatingLabelText: String? {
        return "\(content?.voteAverage ?? 0)"
    }
    
    var contentVotingLabelText: String? {
        return "\(content?.voteCount ?? 0)"
    }
}
