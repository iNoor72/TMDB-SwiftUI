//
//  ProductionCompany+CoreDataClass.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 09/03/2024.
//
//

import Foundation
import CoreData

@objc(ProductionCompany)
public class ProductionCompany: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case id, name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let context = CoreDataManager.shared.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "ProductionCompany", in: context)!
        self.init(entity: entity, insertInto: context)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Int64(try container.decode(Int.self, forKey: .id))
        logoPath = try container.decode(String?.self, forKey: .logoPath)
        name = try container.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(logoPath, forKey: .logoPath)
        try container.encode(name, forKey: .name)
    }
}
