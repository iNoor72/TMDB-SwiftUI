//
//  MoviesListViewModel.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var moviesList: [Movie] = []
    @Published var thrownError: Error? = nil
    @Published var showAlert = false
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
                self?.showAlert = true
                self?.thrownError = error
                
            case .success(let response):
                self?.totalPages = response.totalPages
                self?.moviesList.append(contentsOf: response.movies)
            }
        }
    }
    
    func dismissAlert() {
        showAlert = false
        thrownError = nil
    }
}
