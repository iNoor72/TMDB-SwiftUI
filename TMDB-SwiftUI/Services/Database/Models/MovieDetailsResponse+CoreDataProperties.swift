//
//  MovieDetailsResponse+CoreDataProperties.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//
//

import Foundation
import CoreData


extension MovieDetailsResponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetailsResponse> {
        return NSFetchRequest<MovieDetailsResponse>(entityName: "MovieDetailsResponse")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var homepage: String?
    @NSManaged public var id: Int16
    @NSManaged public var overview: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var tagline: String?
    @NSManaged public var title: String?
    @NSManaged public var productionCompanies: NSSet?

}

// MARK: Generated accessors for productionCompanies
extension MovieDetailsResponse {

    @objc(addProductionCompaniesObject:)
    @NSManaged public func addToProductionCompanies(_ value: ProductionCompany)

    @objc(removeProductionCompaniesObject:)
    @NSManaged public func removeFromProductionCompanies(_ value: ProductionCompany)

    @objc(addProductionCompanies:)
    @NSManaged public func addToProductionCompanies(_ values: NSSet)

    @objc(removeProductionCompanies:)
    @NSManaged public func removeFromProductionCompanies(_ values: NSSet)

}

extension MovieDetailsResponse : Identifiable {

}
