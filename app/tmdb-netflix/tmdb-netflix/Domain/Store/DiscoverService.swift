//
//  DiscoverService.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import Moya
import Alamofire

enum DiscoverService: ApiService {
    
    case movie(parameter: Parameters)
    case tv(parameter: Parameters)
    
    func createEndpoint(_ endpoint: String) -> String {
        return "/discover\(endpoint)"
    }
}

extension DiscoverService: TargetType {
    
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
        case .movie(let parameters), .tv(let parameters):
            return .requestParameters(parameters: stitchApiKey(from: parameters), encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
}

