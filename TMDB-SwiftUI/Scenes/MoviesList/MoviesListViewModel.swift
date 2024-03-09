//
//  MoviesListViewModel.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var moviesList: [Movie] = []
    @Published var showError: (isThereError: Bool, error: Error?) = (false, nil)
    var hasMoreRows = true
    var page = 1
    var totalPages = 1
    private var interactor: MoviesListInteractorProtocol
    
    init(interactor: MoviesListInteractorProtocol = MoviesListInteractor()) {
        self.interactor = interactor
    }
    
    func loadMore() {
        guard page < totalPages else { return }
        page += 1
        fetchMoviesFromAPI()
    }
    
    func fetchMoviesFromAPI() {
        interactor.fetchPopularMovies(page: page) {[weak self] result in
            switch result {
            case .failure(let error):
                self?.showError = (true, error)
                
            case .success(let response):
                self?.totalPages = response.totalPages
                self?.moviesList.append(contentsOf: response.movies)
            }
        }
    }
}
