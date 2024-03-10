//
//  TestEndpoint.swift
//  TMDB-SwiftUITests
//
//  Created by Noor El-Din Walid on 10/03/2024.
//

import Foundation
import Alamofire
@testable import TMDB_SwiftUI

enum TestEndpoint {
    case test
}

extension TestEndpoint: Endpoint {
    var baseURL: URL {
        return URL(string: "https://dummy.com")!
    }
    var path: String {
        return "/test-env"
    }
    
    var parameters: Alamofire.Parameters? {
        nil
    }
    
    var method: Alamofire.HTTPMethod {
        .get
    }
}
