//
//  PosterViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

protocol PosterViewModel: TMDBViewModel {
    
    init(content: Content?)
    
    var posterUrl: String? { get }
    var posterId: Int? { get }
}

final class PosterDefaultViewModel: PosterViewModel {
    
    private let content: Content?
    
    init(content: Content?) {
        self.content = content
    }
    
    var posterUrl: String? {
        return String.init(format: "%@%@", APIConstant.baseImageUrl, content?.posterPath ?? "")
    }
    
    var posterId: Int? {
        return content?.id
    }
}
