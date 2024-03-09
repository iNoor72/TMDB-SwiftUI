//
//  PopularMovieResponse.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

struct PopularMovieResponse: Codable {
    let totalPages: Int
    let page: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
}

// MARK: - Result
struct Movie: Codable, Identifiable, Hashable {
    let backdropPath: String
    let id: Int
    let overview: String
    let posterPath, releaseDate, title: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
