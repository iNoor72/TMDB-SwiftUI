//
//  MovieDetailsResponse.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

struct MovieDetailsResponse: Codable {
    let backdropPath: String
    let homepage: String
    let id: Int
    let overview: String
    let releaseDate: String
    let tagline, title: String
    let productionCompanies: [ProductionCompany]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case homepage, id
        case overview
        case releaseDate = "release_date"
        case tagline, title
        case productionCompanies = "production_companies"
    }
}

struct ProductionCompany: Codable, Hashable, Identifiable {
    let id: Int
    let logoPath: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case id, name
    }
}
