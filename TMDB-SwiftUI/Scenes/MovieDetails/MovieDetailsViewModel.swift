//
//  MovieDetailsViewModel.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    var movieID: Int {
        didSet {
            fetchMovieDetails()
        }
    }
    
    private var interactor: MovieDetailsInteractorProtocol
    @Published var movieDetails: MovieDetailsResponse?
    
    init(movieID: Int, interactor: MovieDetailsInteractorProtocol = MovieDetailsInteractor()) {
        self.interactor = interactor
        self.movieID = movieID
    }
    
    func fetchMovieDetails() {
        interactor.fetchMovieDetails(movieID: movieID) {[weak self] result in
            switch result {
            case .failure(let error):
                //let view = ErrorView(error: error)
                fatalError()
                
            case .success(let response):
                self?.movieDetails = response
            }
        }
    }
}
