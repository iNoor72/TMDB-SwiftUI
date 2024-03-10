//
//  PopularMovieResponse.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

struct PopularMovieResponseCodable: Codable {
    let totalPages: Int
    let page: Int
    let movies: [MovieCodable]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
}

// MARK: - Result
struct MovieCodable: Codable, Identifiable, Hashable {
    let id: Int
    let overview: String
    let posterPath, releaseDate, title: String

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
