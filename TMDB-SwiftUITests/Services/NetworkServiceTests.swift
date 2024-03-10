//
//  NetworkServiceTests.swift
//  TMDB-SwiftUITests
//
//  Created by Noor El-Din Walid on 10/03/2024.
//

import XCTest
@testable import TMDB_SwiftUI

final class NetworkServiceTests: XCTestCase {
    
    var sut: NetworkServiceProtocol!

    override func setUp() {
        super.setUp()
        sut = MockedNetworkService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_calling_mocked_network_fetch() {
        //Given
        let expectedResponse = MockedResponse(id: 111, page: 1, totalPages: 1200)
        let expectation = expectation(description: "Mocked data arrived.")
        
        
        //When
        sut.fetch(endpoint: TestEndpoint.test, expectedType: MockedResponse.self) { result in
            switch result {
            case .failure(_):
                XCTFail("There's no response came out.")
                
            case .success(let response):
                //Then
                XCTAssertEqual(expectedResponse.id, response.id)
                XCTAssertEqual(expectedResponse.page, response.page)
                XCTAssertEqual(expectedResponse.totalPages, response.totalPages)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }

    func test_request_construction() {
        //Given
        let endpoint = TestEndpoint.test
                
        //When
        let myRequestURL = URL(string: "https://dummy.com/test-env")!
        let requestURL = endpoint.requestURL
        
        //Then
        XCTAssertEqual(requestURL, myRequestURL)
    }
}
