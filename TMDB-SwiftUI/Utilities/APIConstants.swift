//
//  APIConstants.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://api.themoviedb.org/3/movie"
    static let imagesBaseURL = "https://image.tmdb.org/t/p/original"
    static let APIKey = "6c52e7203305d7e7c23f306deaf10418"
    
    enum Paths {
        static let popularMoviesPath = "/popular"
    }
}
