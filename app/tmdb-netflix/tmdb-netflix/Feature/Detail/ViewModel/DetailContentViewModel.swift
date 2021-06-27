//
//  DetailContentViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

protocol DetailContentViewModel: TMDBViewModel {
    init(content: Content?)
    
    var posterImageUrl: String? { get }
    var domainLabelText: String? { get }
    var contentTitleLabelText: String? { get }
    var contentStatusLabelText: String? { get }
    var contentReleasedLabelText: String? { get }
    var contentAdultLabelText: String? { get }
    var contentOverviewLabelText: String? { get }
    var contentRatingLabelText: String? { get }
    var contentVotingLabelText: String? { get }
    
}

final class DetailContentDefaultViewModel: DetailContentViewModel {
    
    let content: Content?
    
    var posterImageUrl: String? {
        return String.init(format: "%@%@", APIConstant.baseImageUrl, content?.posterPath ?? "")
    }
    
    var domainLabelText: String? {
        if content is Movie {
            return "M O V I E"
        } else {
            return "T V"
        }
    }
    
    var contentTitleLabelText: String? {
        return content?.title
    }
    
    var contentStatusLabelText: String? {
        return (content?.released ?? false) ? "Released" : "Upcoming"
    }
    
    var contentReleasedLabelText: String? {
        return content?.releaseDate
    }
    
    var contentAdultLabelText: String? {
        return (content?.isAdult ?? false) ? "Adult" : ""
    }
    
    var contentOverviewLabelText: String? {
        return content?.overview
    }
    
    var contentRatingLabelText: String? {
        return "\(content?.voteAverage ?? 0)"
    }
    
    var contentVotingLabelText: String? {
        return "\(content?.voteCount ?? 0)"
    }
    
    init(content: Content?) {
        self.content = content
    }
    
    
}
