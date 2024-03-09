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
    @Published var moviesList: [Movie] = [] {
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
            guard let self else { return }
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.thrownError = error
                }
                
            case .success(let response):
                DispatchQueue.main.async {
                    guard let movies = response.movies?.allObjects as? [Movie] else { return }
                    self.totalPages = Int(response.totalPages)
                    self.moviesList.append(contentsOf: movies)
                    if self.totalPages > self.page { self.hasMoreRows = true }
                }
            }
        }
    }
    
    func resetError() {
        showAlert = false
        thrownError = nil
    }
}
