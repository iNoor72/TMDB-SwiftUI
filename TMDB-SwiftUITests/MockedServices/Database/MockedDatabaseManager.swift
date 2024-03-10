//
//  MockedDatabaseManager.swift
//  TMDB-SwiftUITests
//
//  Created by Noor El-Din Walid on 10/03/2024.
//

import Foundation
import CoreData
@testable import TMDB_SwiftUI

typealias MockedDatabase = DatabaseProtocol & MockedDatabaseService

protocol MockedDatabaseService {
    func getObjectsCount() -> Int
}

class MockedDatabaseManager: DatabaseProtocol, MockedDatabaseService {
    private var cache = [NSManagedObject]()
    
    func save(object: NSManagedObject) {
        cache.append(object)
    }
    
    func fetchMovieDetailsResponses(request: NSFetchRequest<TMDB_SwiftUI.MovieDetailsResponse>) -> [TMDB_SwiftUI.MovieDetailsResponse]? {
        let objects = cache.filter { $0.entity == MovieDetailsResponse.entity() }
        return objects as? [MovieDetailsResponse]
    }
    
    func fetchPopularMovieResponses(request: NSFetchRequest<TMDB_SwiftUI.PopularMovieResponse>) -> [TMDB_SwiftUI.PopularMovieResponse]? {
        let objects = cache.filter { $0.entity == PopularMovieResponse.entity() }
        return objects as? [PopularMovieResponse]
    }
    
    func getObjectsCount() -> Int {
        cache.count
    }
}
