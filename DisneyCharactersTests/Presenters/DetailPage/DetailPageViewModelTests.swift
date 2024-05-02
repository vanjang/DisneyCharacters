//
//  DetailPageViewModelTests.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 01/05/2024.
//

import XCTest
import Combine

import Foundation

@testable import DisneyCharacters

final class DetailPageViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        cancellables.removeAll()
    }
    
    func makeViewModel(id: Int) -> DetailPageViewModel {
        let networkService = NetworkService()
        let localDataService = LocalDataService()
        let apiDataTransferService = NetworkDataTransferService(networkService: networkService)
        let localDataTransferService = LocalDataTransferService(localService: localDataService)
        let repository = DetailPageRepository(apiDataTransferService: apiDataTransferService,
                                              localDataTransferService: localDataTransferService)
        let useCases = DetailPageUseCases(repository: repository)
        return DetailPageViewModel(id: id, useCases: useCases)
    }
    
    func testDidFetchCharacter() throws {
        // GIVEN
        let id = 12
        let viewModel = makeViewModel(id: id)
        let expectation = expectation(description: "testDidFetchCharacter")
        var item: DetailPageItem!
        
        viewModel.$viewState
            .sink { state in
                switch state {
                case .ideal(let i):
                    item = i
                    expectation.fulfill()
                default: break
                }
            }
            .store(in: &cancellables)
        
        // WHEN
        waitForExpectations(timeout: 2)
        
        // THEN
        XCTAssert(item.id == id)
    }
    
    func testDidUpdateFavoriteCharacter() throws {
        // GIVEN
        let viewModel = makeViewModel(id: 12)
        let expectation = expectation(description: "testDidUpdateFavoriteCharacter")
        var firstState: Bool!
        var secondState: Bool!
        
        // if there is no data in user defaults, add one for testing.
        let initialValue = UserDefaults.standard.array(forKey: UserDefaultsKey.favoriteCharacterKey) as? [Int]
        
        if initialValue == nil {
            UserDefaults.standard.setValue([0], forKey: UserDefaultsKey.favoriteCharacterKey)
        }
        
        viewModel.$viewState
            .sink { state in
                switch state {
                case .ideal(let i):
                    if firstState == nil {
                        firstState = i.isFavorite
                    } else {
                        secondState = i.isFavorite
                        expectation.fulfill()
                    }
                default: break
                }
            }
            .store(in: &cancellables)
        
        // WHEN
        viewModel.didTapButton.send(())
        
        // THEN
        waitForExpectations(timeout: 10)
        
        XCTAssert(firstState != secondState)
    }
}
