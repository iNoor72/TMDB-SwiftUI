//
//  LocalizedFetchingErrors.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 10/03/2024.
//

import Foundation

enum LocalizedFetchingErrors: LocalizedError {
    case emptyData
    case failedToFetch
    
    var errorDescription: String? {
        switch self {
        case .emptyData:
            return "The data fetched is empty"
        case .failedToFetch:
            return "A fetching error occured, try again"
        }
    }
}
