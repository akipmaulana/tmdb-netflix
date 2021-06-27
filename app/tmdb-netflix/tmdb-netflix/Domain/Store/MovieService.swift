//
//  MovieService.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Moya
import Alamofire

enum MovieService: ApiService {
    
    case latest
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    func createEndpoint(_ endpoint: String) -> String {
        return "/movie\(endpoint)"
    }
}

extension MovieService: TargetType {
    
    var baseURL: URL {
        return URL(string: baseUrlByVersion )!
    }
    
    var path: String {
        switch self {
        case .latest:
            return createEndpoint("/latest")
        case .nowPlaying:
            return createEndpoint("/now_playing")
        case .popular:
            return createEndpoint("/popular")
        case .topRated:
            return createEndpoint("/top_rated")
        case .upcoming:
            return createEndpoint("/upcoming")
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
        case .latest(let parameters), .upcoming(let parameters), .nowPlaying(let parameters), .popular(let parameters), .topRated(let parameters):
            return .requestParameters(parameters: stitchApiKey(from: parameters), encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
}


