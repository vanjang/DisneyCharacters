//
//  CustomError.swift
//  DisneyCharacters
//
//  Created by myung hoon on 02/05/2024.
//

import Foundation

enum CustomError: LocalizedError {
    case general(Error)
    case network(Error)
    case unknown(String)
}
