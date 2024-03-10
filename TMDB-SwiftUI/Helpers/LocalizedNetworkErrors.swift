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
            return AppStrings.ErrorDescriptions.urlConstructionErrorDescription
        case .noInternet:
            return AppStrings.ErrorDescriptions.noNetworkErrorDescription
        case .failedToFetchData:
            return AppStrings.ErrorDescriptions.serverFetchingErrorDescription
        }
    }
}
 
