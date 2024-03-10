//
//  DatabaseServiceTests.swift
//  TMDB-SwiftUITests
//
//  Created by Noor El-Din Walid on 10/03/2024.
//

import XCTest
import CoreData
@testable import TMDB_SwiftUI

final class DatabaseServiceTests: XCTestCase {
    var sut: MockedDatabase!

    override func setUp() {
        super.setUp()
        sut = MockedDatabaseManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_saving_movie_details_object() {
        //Given
        let managedContext = NSManagedObjectContext(.privateQueue)
        let object = MovieDetailsResponse(context: managedContext)
        object.title = "Tinybeans"
        object.overview = "Private photo sharing app"
        
        //When
        sut.save(object: object)
        
        //Then
        XCTAssertEqual(sut.getObjectsCount(), 1)
    }
    
    func test_saving_popular_response_object() {
        //Given
        let managedContext = NSManagedObjectContext(.privateQueue)
        let object = PopularMovieResponse(context: managedContext)
        object.page = 1
        object.totalPages = 1200
        
        //When
        sut.save(object: object)
        
        //Then
        XCTAssertEqual(sut.getObjectsCount(), 1)
    }
    
    func test_fetching_popular_movie_response() {
        //Given
        let managedContext = NSManagedObjectContext(.privateQueue)
        let object = PopularMovieResponse(context: managedContext)
        object.page = 1
        object.totalPages = 1200
        sut.save(object: object)
        
        //When
        let request = PopularMovieResponse.fetchRequest()
        let objects = sut.fetchPopularMovieResponses(request: request)
        
        //Then
        XCTAssertEqual(objects?.count ?? -1, 1)
    }
    
    func test_fetching_movie_details_response() {
        //Given
        let managedContext = NSManagedObjectContext(.privateQueue)
        let object = MovieDetailsResponse(context: managedContext)
        sut.save(object: object)
        
        //When
        let request = MovieDetailsResponse.fetchRequest()
        let objects = sut.fetchMovieDetailsResponses(request: request)
        
        //Then
        XCTAssertEqual(objects?.count ?? -1, 1)
    }
}
