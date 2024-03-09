//
//  MoviesListInteractor.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

protocol MoviesListInteractorProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping (Result<PopularMovieResponse, Error>) -> ())
}

final class MoviesListInteractor: MoviesListInteractorProtocol {
    private let repository: MoviesListRepositoryProtocol
    
    init
    (
        repository: MoviesListRepositoryProtocol = MoviesListRepository(
            networkService: AlamofireNetworkManager(),
            database: DatabaseManager()
        )
    ) {
        self.repository = repository
    }
    
    func fetchPopularMovies(page: Int = 1, completion: @escaping (Result<PopularMovieResponse, Error>) -> ()) {
        repository.fetchPopularMovies(page: page) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response))
            }
        }
    }
}
