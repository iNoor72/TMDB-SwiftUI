//
//  MoviesListInteractor.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

protocol MoviesListInteractorProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping (Result<PopularMovieResponse, Error>) -> ())
    func viewItem(movie: Movie) -> MovieViewItem?
}

final class MoviesListInteractor: MoviesListInteractorProtocol {
    private let repository: MoviesListRepositoryProtocol
    
    init
    (
        repository: MoviesListRepositoryProtocol = MoviesListRepository(
            networkService: AlamofireNetworkManager(),
            database: CoreDataManager.shared
        )
    ) {
        self.repository = repository
    }
    
    func viewItem(movie: Movie) -> MovieViewItem? {
        let movieViewItem = MovieViewItem(
            id: Int(movie.id),
            overview: movie.overview ?? "",
            posterPath: movie.posterPath ?? "",
            releaseDate: movie.releaseDate ?? "",
            title: movie.title ?? ""
        )
        
        return movieViewItem
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

struct MovieViewItem: Hashable {
    let id: Int
    let overview: String
    let posterPath, releaseDate, title: String
}
