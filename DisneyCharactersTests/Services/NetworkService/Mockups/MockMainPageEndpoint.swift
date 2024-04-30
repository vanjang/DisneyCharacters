//
//  MockMainPageEndpoint.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation
@testable import DisneyCharacters

struct MockMainPageEndopoint: Endpoint {
    var baseURL: String
    var path: String = ""
    var method: HTTPMethod = .get
    var parameters: [URLQueryItem]? = nil
    var headers: [String : String]? = nil
}
