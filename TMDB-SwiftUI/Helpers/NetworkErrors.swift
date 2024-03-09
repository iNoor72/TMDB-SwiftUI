//
//  NetworkErrors.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//

import Foundation

enum NetworkErrors: Error {
    case urlRequestConstructionError
    case noInternet
    case failedToFetchData
}
