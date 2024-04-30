//
//  MockData.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 30/04/2024.
//


import Foundation
import XCTest

struct MockData {
    static let url = Bundle(for: NetworkServiceTests.self).url(forResource: "mockCharacterJson", withExtension: "json")
    
    static var data: Data {
        guard let resourceUrl = url, let data = try? Data(contentsOf: resourceUrl) else {
            XCTFail("Failed to create data object.")
            return Data()
        }
        return data
    }
}
