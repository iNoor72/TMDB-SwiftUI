//
//  MoviesListViewModel.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    @Published var thrownError: LocalizedNetworkErrors?
    @Published var showAlert = false
    @Published var movieViewItems: [MovieViewItem] = [] {
        didSet {
            print(movieViewItems)
        }
    }
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
        fetchMoviesFromAPI()
    }
    
    private func handleMovieViewItems() {
        movieViewItems = []
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
                    let error = error as? NetworkErrors
                    switch error {
                    case .noInternet:
                        self.thrownError = LocalizedNetworkErrors.noInternet
                    case .urlRequestConstructionError:
                        self.thrownError = LocalizedNetworkErrors.urlRequestConstructionError
                    case .failedToFetchData:
                        self.thrownError = LocalizedNetworkErrors.failedToFetchData
                    case .none:
                        return
                    }
                }
                
            case .success(let response):
                DispatchQueue.main.async {
                    guard let movies = response.movies?.allObjects as? [Movie] else { return }
                    self.totalPages = Int(response.totalPages)
                    self.moviesList.append(contentsOf: movies.sorted(by: {
                        $0.releaseDate ?? "" > $1.releaseDate ?? ""
                    }))
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
