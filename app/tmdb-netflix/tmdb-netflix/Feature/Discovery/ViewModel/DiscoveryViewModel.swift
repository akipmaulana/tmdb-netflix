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
}

final class DiscoveryDefaultViewModel: DiscoveryViewModel {
    
    private let kind: DiscoveryKind
    
    var titleDomainLabelText: String {
        return kind.title
    }
    
    init(kind: DiscoveryKind) {
        self.kind = kind
    }
    
}
