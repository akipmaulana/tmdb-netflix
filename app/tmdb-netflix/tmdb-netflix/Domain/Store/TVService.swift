//
//  TVService.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Moya
import Alamofire

enum TVService: ApiService {
    
    case latest
    case airingToday
    case onTheAir
    case topRated
    case popular
    case review(id: Int, parameters: Parameters)
    
    func createEndpoint(_ endpoint: String) -> String {
        return "/tv\(endpoint)"
    }
}

extension TVService: TargetType {
    
    var baseURL: URL {
        return URL(string: baseUrlByVersion )!
    }
    
    var path: String {
        switch self {
        case .latest:
            return createEndpoint("/latest")
        case .airingToday:
            return createEndpoint("/airing_today")
        case .popular:
            return createEndpoint("/popular")
        case .topRated:
            return createEndpoint("/top_rated")
        case .onTheAir:
            return createEndpoint("/on_the_air")
        case .review(let id, _):
            return createEndpoint("/\(id)/reviews")
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
        case .latest, .onTheAir, .airingToday, .popular, .topRated:
            return .requestParameters(parameters: stitchApiKey(from: [:]), encoding: URLEncoding.queryString)
        case .review(_, let parameters):
            return .requestParameters(parameters: stitchApiKey(from: parameters), encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
}


