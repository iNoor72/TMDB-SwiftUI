//
//  MovieDetailsInteractor.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

protocol MovieDetailsInteractorProtocol {
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> ())
}

final class MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    private let repository: MovieDetailsRepositoryProtocol
    
    init(
        repository: MovieDetailsRepositoryProtocol = MovieDetailsRepository(
            networkService: AlamofireNetworkManager(),
            database: DatabaseManager()
        ) 
    ) {
        self.repository = repository
    }
    
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> ()) {
        repository.fetchMovieDetails(movieID: movieID) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response))
            }
        }
    }
}