//
//  LocalDataServiceTests.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 01/05/2024.
//

import XCTest
@testable import DisneyCharacters

final class LocalDataServiceTests: XCTestCase {
    
    var localDataService: LocalDataServiceType!
    
    override func setUp() {
        super.setUp()
        localDataService = LocalDataService()
    }
    
    override func tearDown() {
        localDataService = nil
        super.tearDown()
    }
    
    func testAddFavoriteCharacter() {
        let idToAdd = 1234567890
        localDataService.addFavoriteCharacter(id: idToAdd)
        XCTAssertTrue(localDataService.favoriteCharacterIds.contains(idToAdd))
    }
    
    func testRemoveFavoriteCharacter() {
        let idToRemove = 0987654321
        localDataService.addFavoriteCharacter(id: idToRemove)
        XCTAssertTrue(localDataService.favoriteCharacterIds.contains(idToRemove))
        
        localDataService.removeFavoriteCharacter(id: idToRemove)
        XCTAssertFalse(localDataService.favoriteCharacterIds.contains(idToRemove))
    }
}
