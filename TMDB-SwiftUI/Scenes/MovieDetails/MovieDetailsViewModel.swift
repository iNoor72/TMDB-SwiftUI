//
//  MovieDetailsViewModel.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    var movieID: String
    
    init(movieID: String) {
        self.movieID = movieID
    }
}
