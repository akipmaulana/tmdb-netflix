//
//  DThematicViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

protocol DThematicViewModel: TMDBViewModel {
    init(data: ThematicData?)
    
    var thematicTitleLabelText: String? { get }
    
    var content: [Content] { get }
    
    func getSafeContent(at position: Int) -> Content?
}

final class DThematiceDefaultViewModel: DThematicViewModel {
    
    private let data: ThematicData?
    
    init(data: ThematicData?) {
        self.data = data
    }
    
    var thematicTitleLabelText: String? {
        return data?.thematic.name
    }
    
    var content: [Content] {
        return data?.content ?? []
    }
    
    func getSafeContent(at position: Int) -> Content? {
        if content.indices.contains(position) {
            return content[position]
        }
        return nil
    }
}
