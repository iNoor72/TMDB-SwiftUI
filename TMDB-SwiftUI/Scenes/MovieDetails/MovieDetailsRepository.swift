//
//  MovieDetailsRepository.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

protocol MovieDetailsRepositoryProtocol {
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> ())
}

final class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    let database: DatabaseProtocol
    
    init(networkService: NetworkServiceProtocol, database: DatabaseProtocol) {
        self.networkService = networkService
        self.database = database
    }
    
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> ()) {
        let endpoint = MoviesEndpoint.movieDetails(movieID: movieID)
        networkService.fetch(endpoint: endpoint, expectedType: MovieDetailsResponse.self) {[weak self] result in
            switch result {
            case .failure(let error):
                guard let response = self?.handleDataResponse() else {
                    completion(.failure(error))
                    return
                }
                
                completion(.success(response))
                
            case .success(let response):
                //save to DB
                completion(.success(response))
            }
        }
    }
    
    private func handleDataResponse() -> MovieDetailsResponse? {
        var response: MovieDetailsResponse? = nil
            //Check if there's something in DB
        return response
    }
}
