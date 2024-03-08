//
//  MoviesListViewModel.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var moviesList: [Movie] = []
    var page = 1
    private var interactor: MoviesListInteractorProtocol
    
    init(interactor: MoviesListInteractorProtocol = MoviesListInteractor()) {
        self.interactor = interactor
    }
    
    func fetchMoviesFromAPI() {
        interactor.fetchPopularMovies(page: page) {[weak self] result in
            switch result {
            case .failure(let error):
                fatalError()
                
            case .success(let response):
                self?.moviesList = response.movies
            }
        }
    }
    
    
}
