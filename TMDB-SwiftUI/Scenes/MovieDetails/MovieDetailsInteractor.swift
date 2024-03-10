//
//  MovieDetailsInteractor.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

protocol MovieDetailsInteractorProtocol {
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> ())
    func productionCompanyViewItem(company: ProductionCompany) -> ProductionCompanyViewItem?
}

final class MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    private let repository: MovieDetailsRepositoryProtocol
    
    init(
        repository: MovieDetailsRepositoryProtocol = MovieDetailsRepository(
            networkService: AlamofireNetworkManager(),
            database: CoreDataManager.shared
        ) 
    ) {
        self.repository = repository
    }
    
    func productionCompanyViewItem(company: ProductionCompany) -> ProductionCompanyViewItem? {
        let productionCompanyViewItem = ProductionCompanyViewItem(
            id: Int(company.id),
            logoPath: company.logoPath,
            name: company.name ?? ""
        )
        
        return productionCompanyViewItem
    }
    
    func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> ()) {
        repository.fetchMovieDetails(movieID: movieID) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response))
            }
        }
    }
}

struct ProductionCompanyViewItem: Hashable {
    let id: Int
    let logoPath: String?
    let name: String
}
