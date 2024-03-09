//
//  MoviesListViewModel.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var thrownError: Error? = nil
    @Published var showAlert = false
    @Published var movieViewItems: [MovieViewItem] = []
    @Published var moviesList: [MovieCodable] = [] {
        didSet {
            handleMovieViewItems()
        }
    }
    
    private var interactor: MoviesListInteractorProtocol
    var hasMoreRows = false
    var page = 1
    var totalPages = 1
    
    init(interactor: MoviesListInteractorProtocol = MoviesListInteractor()) {
        self.interactor = interactor
    }
    
    private func handleMovieViewItems() {
        for movie in moviesList {
            guard let movieViewItem = interactor.viewItem(movie: movie) else { continue }
            movieViewItems.append(movieViewItem)
        }
    }
    
    func loadMore() {
        guard page < totalPages else {
            hasMoreRows = false
            return
        }
        
        hasMoreRows = true
        page += 1
        fetchMoviesFromAPI()
    }
    
    func fetchMoviesFromAPI() {
        interactor.fetchPopularMovies(page: page) {[weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert = true
                    self?.thrownError = error
                }
                
            case .success(let response):
                DispatchQueue.main.async {
                    self?.totalPages = response.totalPages
                    self?.moviesList.append(contentsOf: response.movies)
                }
            }
        }
    }
    
    func resetError() {
        showAlert = false
        thrownError = nil
    }
}
