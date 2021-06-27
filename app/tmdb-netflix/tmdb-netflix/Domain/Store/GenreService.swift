//
//  GenreService.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Moya
import Alamofire

enum GenreService: ApiService {
    
    case movie
    case tv
    
    func createEndpoint(_ endpoint: String) -> String {
        return "/genre\(endpoint)/list"
    }
}

extension GenreService: TargetType {
    
    var baseURL: URL {
        return URL(string: baseUrlByVersion )!
    }
    
    var path: String {
        switch self {
        case .movie:
            return createEndpoint("/movie")
        case .tv:
            return createEndpoint("/tv")
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .movie, .tv:
            return .requestParameters(parameters: stitchApiKey(from: [:]), encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}


