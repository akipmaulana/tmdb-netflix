//
//  GeneralUtil.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import Foundation

final class GeneralUtil {
    
    static let instance = GeneralUtil()
    
    private init() {}
    
    let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
}
