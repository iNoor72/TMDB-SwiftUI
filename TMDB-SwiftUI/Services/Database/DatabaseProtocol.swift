//
//  DatabaseProtocol.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation
import CoreData

protocol DatabaseProtocol {
    func save(object: NSManagedObject)
//    func fetch(request: NSFetchRequest<NSFetchRequestResult>) -> NSManagedObject?
}
