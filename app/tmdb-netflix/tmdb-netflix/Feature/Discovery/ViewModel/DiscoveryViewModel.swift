//
//  DiscoveryViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

protocol DiscoveryViewModel: TMDBViewModel {
    init(kind: DiscoveryKind)
    
    var titleDomainLabelText: String { get }
    
    func getSafeThematic(at position: Int) -> ThematicProtocol?
}

final class DiscoveryDefaultViewModel: DiscoveryViewModel {
    
    private let kind: DiscoveryKind
    
    var titleDomainLabelText: String {
        switch kind {
        case .movie:
            return "Movie"
        case .tv:
            return "TV Series"
        }
    }
    
    var thematics: [ThematicProtocol] {
        switch kind {
        case .movie:
            return MovieThematicKind.all
        case .tv:
            return TVThematicKind.all
        }
    }
    
    init(kind: DiscoveryKind) {
        self.kind = kind
    }
    
    func getSafeThematic(at position: Int) -> ThematicProtocol? {
        if thematics.indices.contains(position) {
            return thematics[position]
        } else {
            return nil
        }
    }
}
