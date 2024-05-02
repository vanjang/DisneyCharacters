//
//  API.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

/// An API components such as base url, path, and query keys.
enum API {
    static var baseUrlString: String { "https://api.disneyapi.dev" }
    
    enum Paths: String {
        case character = "/character"
    }
    
    enum Queries: String {
        case page = "page"
        case pageSize = "pageSize"
    }
}
