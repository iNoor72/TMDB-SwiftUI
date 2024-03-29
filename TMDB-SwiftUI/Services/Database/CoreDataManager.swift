//
//  DatabaseManager.swift
//  TMDB-SwiftUI
//
//  Created by Noor El-Din Walid on 08/03/2024.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() { 
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: AppConstants.CoreDataModelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        return managedObjectModel
    }()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        let fileManager = FileManager.default
        let storeName = "\(AppConstants.CoreDataModelName).sqlite"

        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }

        return persistentStoreCoordinator
    }()
}

extension CoreDataManager: DatabaseProtocol {
    func save(object: NSManagedObject) {
        let objects = self.managedObjectContext.insertedObjects.filter { $0.entity == object.entity }
        guard objects.contains(object) else { return }
        
        managedObjectContext.perform { [weak self] in
            guard let self else { return }
            self.managedObjectContext.insert(object)
            try? self.managedObjectContext.save()
        }
    }
    
    func fetchPopularMovieResponses(request: NSFetchRequest<PopularMovieResponse>) -> [PopularMovieResponse]? {
        let objects = try? managedObjectContext.fetch(request)
        return objects
    }
    
    func fetchMovieDetailsResponses(request: NSFetchRequest<MovieDetailsResponse>) -> [MovieDetailsResponse]? {
        let objects = try? managedObjectContext.fetch(request)
        return objects
    }
}
