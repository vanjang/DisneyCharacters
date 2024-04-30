//
//  Character.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

struct Character: Decodable {
    private let _id: Int
    var id: Int { _id }
    let films: [String]
    let shortFilms: [String]
    let tvShows: [String]
    let name: String
    let imageUrl: String?
    let url: String
}
