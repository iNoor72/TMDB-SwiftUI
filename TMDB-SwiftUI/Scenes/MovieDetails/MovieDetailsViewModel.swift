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
    @Published var movieDetails: MovieDetailsResponse? {
        didSet {
            handleProductionComapnyViewItem()
        }
    }
    @Published var showError: (isThereError: Bool, error: Error?) = (false, nil)
    @Published var productionCompanies: [ProductionCompanyViewItem] = []
    
    init(movieID: Int, interactor: MovieDetailsInteractorProtocol = MovieDetailsInteractor()) {
        self.interactor = interactor
        self.movieID = movieID
    }
    
    private func handleProductionComapnyViewItem() {
        productionCompanies = []
        guard let productionCompaniesArray = (movieDetails?.productionCompanies?.allObjects as? [ProductionCompany])?.sorted(by: {
            $0.name ?? "" < $1.name ?? ""
        }) else { return }
        for company in productionCompaniesArray {
            guard let productionCompanyViewItem = interactor.productionCompanyViewItem(company: company) else { continue }
            productionCompanies.append(productionCompanyViewItem)
        }
    }
    
    func fetchMovieDetails() {
        interactor.fetchMovieDetails(movieID: movieID) {[weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError = (true, error)
                }
                
            case .success(let response):
                DispatchQueue.main.async {
                    self?.movieDetails = response
                }
            }
        }
    }
}
