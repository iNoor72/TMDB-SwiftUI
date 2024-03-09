//
//  MoviesListRepository.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

protocol MoviesListRepositoryProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping (Result<PopularMovieResponseCodable, Error>) -> ())
}

final class MoviesListRepository: MoviesListRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    let database: DatabaseProtocol
    
    init(networkService: NetworkServiceProtocol, database: DatabaseProtocol) {
        self.networkService = networkService
        self.database = database
    }
    
    func fetchPopularMovies(page: Int = 1, completion: @escaping (Result<PopularMovieResponseCodable, Error>) -> ()) {
        let endpoint = MoviesEndpoint.popularMovies(page: page)
        networkService.fetch(endpoint: endpoint, expectedType: PopularMovieResponseCodable.self) {[weak self] result in
            switch result {
            case .failure(let error):
                guard let response = self?.handleDataResponse(), !response.movies.isEmpty else {
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
    
    private func handleDataResponse() -> PopularMovieResponseCodable? {
        var response: PopularMovieResponseCodable? = nil
            //Check if there's something in DB
        return response
    }
}
