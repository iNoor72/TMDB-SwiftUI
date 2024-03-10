//
//  MockedNetworkService.swift
//  TMDB-SwiftUITests
//
//  Created by Noor El-Din Walid on 10/03/2024.
//

import Foundation
@testable import TMDB_SwiftUI

class MockedNetworkService: NetworkServiceProtocol {
    private var mockedResponse: MockedResponse
    
    init() {
        mockedResponse = MockedResponse(id: 111, page: 1, totalPages: 1200)
    }
    
    func fetch<U, T>(endpoint: U, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> ()) where U : TMDB_SwiftUI.Endpoint, T : Decodable {
        completion(.success(mockedResponse as! T))
    }
}
