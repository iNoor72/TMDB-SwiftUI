//
//  ProductionCompany+CoreDataProperties.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//
//

import Foundation
import CoreData


extension ProductionCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductionCompany> {
        return NSFetchRequest<ProductionCompany>(entityName: "ProductionCompany")
    }

    @NSManaged public var id: Int64
    @NSManaged public var logoPath: String?
    @NSManaged public var name: String?
    @NSManaged public var movie: MovieDetailsResponse?

}

extension ProductionCompany : Identifiable {
}
