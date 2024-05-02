//
//  MainPageRepositoryPage.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 30/04/2024.
//

import XCTest
import Combine
@testable import DisneyCharacters

final class MainPageRepositoryTests: XCTestCase {
    
    var cancellables: [AnyCancellable] = []
    
    func testMainPagePagination() throws {
        // GIVEN
        let apiDataTransferService = NetworkDataTransferService(networkService: NetworkService())
        let localDataTransferService = LocalDataTransferService(localService: LocalDataService())
        let repo = MainPageRepository(apiDataTransferService: apiDataTransferService, localDataTransferService: localDataTransferService)
        let loadNext = PassthroughSubject<Void, Never>()
        let expectation = expectation(description: "testMainPagePagination")
        var characters: [Character] = []
        var numberOfLoads = 0
        let limit: Int = 5
        
        // WHEN
        repo.fetchCharacters(load: loadNext, limit: limit)
            .replaceError(with: [])
            .sink { elements in
                characters = elements
                numberOfLoads = numberOfLoads + 1
                
                if numberOfLoads == 1 {
                    loadNext.send(())
                } else if numberOfLoads == 2 {
                    loadNext.send(())
                } else if numberOfLoads == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        loadNext.send(())
        
        // THEN
        waitForExpectations(timeout: 5.0)
        XCTAssert(characters.count == limit * numberOfLoads)
    }
}
