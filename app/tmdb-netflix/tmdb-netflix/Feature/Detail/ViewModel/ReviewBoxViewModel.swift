//
//  ReviewBoxViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

protocol ReviewBoxViewModel: TMDBViewModel {
    init(review: Review?)
    
    var avatarUrl: String? { get }
    var nameLabelText: String? { get }
    var dateLabelText: String? { get }
    var contentLabelText: String? { get }
}

final class ReviewBoxDefaultViewModel: ReviewBoxViewModel {
    
    private let review: Review?
    
    init(review: Review?) {
        self.review = review
    }
    
    var avatarUrl: String? {
        String.init(format: "%@%@", APIConstant.baseImageUrl, review?.authorDetail?.avatarPath ?? "")
    }
    
    var nameLabelText: String? {
        return review?.author ?? review?.authorDetail?.username
    }
    
    var dateLabelText: String? {
        if let rating = review?.authorDetail?.rating, rating > 0 {
            return "\(review?.updatedAt ?? review?.createdAt ?? "") • \(rating)"
        }
        return review?.updatedAt ?? review?.createdAt
    }
    
    var contentLabelText: String? {
        return review?.content ?? ""
    }
    
}
