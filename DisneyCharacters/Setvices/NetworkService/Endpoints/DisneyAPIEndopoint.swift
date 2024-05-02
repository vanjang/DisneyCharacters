//
//  DisneyAPIEndopoint.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

struct DisneyAPIEndopoint: Endpoint {
    var baseURL: String { API.baseUrlString }
    var path: String
    var method: HTTPMethod
    var parameters: [URLQueryItem]?
    var headers: [String : String]?
}
