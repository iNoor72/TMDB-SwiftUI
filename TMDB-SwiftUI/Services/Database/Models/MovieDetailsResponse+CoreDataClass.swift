//
//  MovieDetailsResponse+CoreDataClass.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//
//

import Foundation
import CoreData

@objc(MovieDetailsResponse)
public class MovieDetailsResponse: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case homepage, id
        case overview
        case releaseDate = "release_date"
        case tagline, title
        case productionCompanies = "production_companies"
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let context = CoreDataManager.shared.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "PopularMovieResponse", in: context)!
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Int64(try container.decode(Int.self, forKey: .id))
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
        homepage = try container.decode(String.self, forKey: .homepage)
        overview = try container.decode(String.self, forKey: .overview)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        title = try container.decode(String.self, forKey: .title)
        tagline = try container.decode(String.self, forKey: .tagline)
        productionCompanies = NSSet(array: try container.decode([ProductionCompany].self, forKey: .productionCompanies))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(homepage, forKey: .homepage)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(overview, forKey: .overview)
        try container.encode(title, forKey: .title)
        try container.encode(tagline, forKey: .tagline)
        let productionCompaniesArray = productionCompanies?.allObjects as? [ProductionCompany]
        try container.encode(productionCompaniesArray, forKey: .productionCompanies)
    }
}
