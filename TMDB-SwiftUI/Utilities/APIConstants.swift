//
//  APIConstants.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://api.themoviedb.org/3/movie"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MDExZjNmZGM2NTUxZWJlNTQ3ZjE4MWM3OTY4MGI2NiIsInN1YiI6IjVmNGJlY2UzMTJhYWJjMDAzNGE3YzRjYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.v78toPmKrx5CQcZEF79CiPQcCoZURpaFBl-P1-0xprs"
    
    enum Paths {
        static let popularMoviesPath = "/popular"
    }
}
