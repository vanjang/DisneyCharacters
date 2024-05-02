//
//  DetailPageRepositoryTests.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 01/05/2024.
//

import XCTest
import Combine
@testable import DisneyCharacters

final class DetailPageRepositoryTests: XCTestCase {
    var cancellables: [AnyCancellable] = []
    
    func testCharacterRetrieval() throws {
        // GIVEN
        let apiDataTransferService = NetworkDataTransferService(networkService: NetworkService())
        let localDataTransferService = LocalDataTransferService(localService: LocalDataService())
        let repo = DetailPageRepository(apiDataTransferService: apiDataTransferService, localDataTransferService: localDataTransferService)
        var character: Character!
        let expectation = expectation(description: "testCharacterRetrieval")
        let id = 12
        
        // WHEN
        repo.fetchCharacter(id: id)
            .sink { _ in } receiveValue: { c in
                character = c
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // THEN
        waitForExpectations(timeout: 5.0)
        XCTAssert(character.id == id)
    }
}
