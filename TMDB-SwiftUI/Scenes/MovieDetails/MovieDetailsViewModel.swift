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
    @Published var showAlert = false
    @Published var thrownError: LocalizedNetworkErrors?
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
                    self.movieDetails = response
                }
            }
        }
    }
    
    func resetError() {
        showAlert = false
        thrownError = nil
    }
}
