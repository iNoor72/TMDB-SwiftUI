//
//  AlamofireNetworkManager.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation
import Alamofire

final class AlamofireNetworkManager: NetworkServiceProtocol {
    func fetch<U: Endpoint, T: Decodable>(endpoint: U, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        guard let reachability = NetworkReachabilityManager(), reachability.isReachable else {
            completion(.failure(NetworkErrors.noInternet))
            return
        }
        
        guard let requestURL = try? endpoint.asURLRequest() else {
            completion(.failure(NetworkErrors.urlRequestConstructionError))
            return
        }
        
        AF.request(requestURL).validate().responseDecodable(queue: .global()) { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .failure(_):
                completion(.failure(NetworkErrors.failedToFetchData))
                
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
