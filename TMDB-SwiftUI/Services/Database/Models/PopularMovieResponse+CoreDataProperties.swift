//
//  PopularMovieResponse+CoreDataProperties.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//
//

import Foundation
import CoreData


extension PopularMovieResponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PopularMovieResponse> {
        return NSFetchRequest<PopularMovieResponse>(entityName: "PopularMovieResponse")
    }

    @NSManaged public var totalPages: Int16
    @NSManaged public var page: Int16
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension PopularMovieResponse {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension PopularMovieResponse : Identifiable {

}
