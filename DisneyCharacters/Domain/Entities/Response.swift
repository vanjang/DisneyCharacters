//
//  Response.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let data: T
}
