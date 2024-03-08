//
//  PopularMovieResponse.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

struct PopularMovieResponse: Codable {
    let page: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page, results
    }
}

// MARK: - Result
struct Movie: Codable {
    let backdropPath: String
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
