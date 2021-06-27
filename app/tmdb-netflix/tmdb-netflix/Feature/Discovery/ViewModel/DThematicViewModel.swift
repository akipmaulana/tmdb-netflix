//
//  DThematicViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

protocol DThematicViewModel: TMDBViewModel {
    init(thematic: ThematicProtocol?)
    
    var thematicTitleLabelText: String? { get }
}

final class DThematiceDefaultViewModel: DThematicViewModel {
    
    private let thematic: ThematicProtocol?
    
    init(thematic: ThematicProtocol?) {
        self.thematic = thematic
    }
    
    var thematicTitleLabelText: String? {
        return thematic?.name
    }
}
