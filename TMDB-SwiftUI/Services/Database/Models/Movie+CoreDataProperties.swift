//
//  Movie+CoreDataProperties.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int16
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var response: PopularMovieResponse?

}

extension Movie : Identifiable {

}
