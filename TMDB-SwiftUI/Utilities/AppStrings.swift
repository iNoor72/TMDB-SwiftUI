//
//  AppStrings.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation

enum AppStrings {
    static let noNetworkAlertMessage = "You're not connected to network, you'll be using the app in the offline mode"
    
    enum ErrorDescriptions {
        static let emptryDataErrorDescription = "The data fetched is empty"
        static let fetchingErrorDescription = "A fetching error occured, try again"
        static let urlConstructionErrorDescription = "There was an error getting data from URL. Please try again later"
        static let noNetworkErrorDescription = "You're offline. Please reconnect to the network"
        static let serverFetchingErrorDescription = "There was an error fetching data from server"
    }
}
