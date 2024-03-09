//
//  AlamofireNetworkManager.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation
import Alamofire

enum NetworkErrors: Error {
    case urlRequestConstructionError
    case noInternet
    
    var description: String {
        switch self {
        case .urlRequestConstructionError:
            return "There was an error getting data from URL. Please try again later."
        case .noInternet:
            return "You're offline. Please reconnect to the network."
        }
    }
}

final class AlamofireNetworkManager: NetworkServiceProtocol {
    func fetch<U: Endpoint, T: Decodable>(endpoint: U, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        guard let requestURL = try? endpoint.asURLRequest() else {
            completion(.failure(NetworkErrors.urlRequestConstructionError))
            return
        }
        
        AF.request(requestURL).validate().responseDecodable(queue: .global()) { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
