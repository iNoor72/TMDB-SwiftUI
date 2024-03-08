//
//  MoviesEndpoint.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation
import Alamofire

enum MoviesEndpoint {
    case popularMovies(page: Int)
    case movieDetails(movieID: String)
}

extension MoviesEndpoint: Endpoint {
    var baseURL: URL {
        guard let url = URL(string: APIConstants.baseURL) else { fatalError("Base URL isn't valid.") }
        return url
    }
    
    var path: String {
        switch self {
        case .movieDetails(let movieID):
            return "/\(movieID)"
            
        case .popularMovies:
            return APIConstants.Paths.popularMoviesPath
        }
    }
    
    var parameters: Alamofire.Parameters? {
        return ["api_key": APIConstants.APIKey]
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .movieDetails, .popularMovies:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return  ["accept": "application/json"]
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.headers = headers
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        try encoding.encode(urlRequest, with: parameters)
    }
}
