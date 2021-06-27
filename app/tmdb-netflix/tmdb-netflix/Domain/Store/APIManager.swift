//
//  APIManager.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import Foundation
import Moya
import Alamofire

protocol ApiService {
    func stitchApiKey(from parameters: Parameters) -> Parameters
    func createEndpoint(_ endpoint: String) -> String
    var version: ApiVersion { get }
    var baseUrlByVersion: String { get }
}

extension ApiService {
    var version: ApiVersion {
        return .v3
    }
    
    var baseUrlByVersion: String {
        return String.init(format: "%@/%@", APIConstant.baseUrl, version.rawValue)
    }
    
    func stitchApiKey(from parameters: Parameters) -> Parameters {
        var newParams: Parameters = parameters
        newParams["api_key"] = APIConstant.apikey
        newParams["language"] = "en-US"
        return newParams
    }
}

class ApiManager {
    
    private init() {
    }
    
    static let shared = ApiManager()
    
    let discoverService = InnerApiManager<DiscoverService>()
}

class InnerApiManager<T: TargetType> {
    
    private let provider = MoyaProvider<T>(manager: DefaultAlamofireManager.sharedManager, plugins: [
        NetworkLoggerPlugin(verbose: true),
        ])
    private let jsonDecoder: JSONDecoder = {
        return GeneralUtil.instance.jsonDecoder
    }()
    
    func request<BR>(target: T, mapper: BR.Type = BR.self, success: ApiSuccessClosure<BR>?, error: ErrorClosure?) where BR : Codable {
        
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                
                do {
                    
                    let json = try? JSONSerialization.jsonObject(with: response.data, options: [])
                    
                    if let _ = json as? [[String:Any]] {
                        let successResponse = try self.jsonDecoder.decode(mapper, from: response.data)
                        success?(successResponse)
                    } else {
                        error?(ApiError.apiServer(code: -999, message: "Json not supported"))
                    }
                    
                } catch let err {
                    if let _ = err as? DecodingError {
                        error?(ApiError.apiServer(code: -999, message: "Ups, Payload from the server is not supported. Please try again."))
                        print(err)
                    } else {
                        error?(err)
                    }
                }
                break
            case .failure(let err):
                error?(err)
                break
            }
        }
    }
}

private class DefaultAlamofireManager: Alamofire.SessionManager {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [:]
        configuration.timeoutIntervalForRequest = 60 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 60 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let manager = DefaultAlamofireManager(configuration: configuration)
        return manager
    }()
}
