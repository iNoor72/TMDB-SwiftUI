//
//  MoviesListRepository.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation
import CoreData

protocol MoviesListRepositoryProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping (Result<PopularMovieResponse, Error>) -> ())
}

final class MoviesListRepository: MoviesListRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    let database: DatabaseProtocol
    
    init(networkService: NetworkServiceProtocol, database: DatabaseProtocol) {
        self.networkService = networkService
        self.database = database
    }
    
    func fetchPopularMovies(page: Int = 1, completion: @escaping (Result<PopularMovieResponse, Error>) -> ()) {
        let endpoint = MoviesEndpoint.popularMovies(page: page)
        networkService.fetch(endpoint: endpoint, expectedType: PopularMovieResponse.self) {[weak self] result in
            guard let self else { return }
            switch result {
            case .failure(let error):
                guard
                    let response = self.handleDataResponse(),
                    let moviesArray = response.movies?.allObjects,
                    !moviesArray.isEmpty,
                    page == 1
                else {
                    completion(.failure(error))
                    return
                }
                
                completion(.success(response))
                
            case .success(let response):
                self.database.save(object: response)
                completion(.success(response))
            }
        }
    }
    
    private func handleDataResponse() -> PopularMovieResponse? {
        var response: PopularMovieResponse? = nil
        let fetchRequest = PopularMovieResponse.fetchRequest()
        if let firstResponse = database.fetchPopularMovieResponses(request: fetchRequest)?.first {
            response = firstResponse
        }
        return response
    }
}
