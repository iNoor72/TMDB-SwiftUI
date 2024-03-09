//
//  LocalizedNetworkErrors.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//

import Foundation

enum LocalizedNetworkErrors: LocalizedError {
    case urlRequestConstructionError
    case noInternet
    case failedToFetchData
    
    var errorDescription: String? {
        switch self {
        case .urlRequestConstructionError:
            return "There was an error getting data from URL. Please try again later"
        case .noInternet:
            return "You're offline. Please reconnect to the network"
        case .failedToFetchData:
            return "There was an error fetching data from server"
        }
    }
}
 
