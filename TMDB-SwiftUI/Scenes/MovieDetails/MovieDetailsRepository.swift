//
//  MovieDetailsRepository.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation
import CoreData

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
            guard let self else { return }
            switch result {
            case .failure(let error):
                guard let response = self.handleDataResponse(movieID: movieID) else {
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
    
    private func handleDataResponse(movieID: Int) -> MovieDetailsResponse? {
        var response: MovieDetailsResponse? = nil
        let fetchRequest = MovieDetailsResponse.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: movieID))
        
        if let firstResponse = database.fetchMovieDetailsResponses(request: fetchRequest)?.first {
            response = firstResponse
        }
        return response
    }
}
