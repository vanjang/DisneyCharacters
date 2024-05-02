//
//  MainPageViewModelTests.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 30/04/2024.
//

import XCTest
import Combine
@testable import DisneyCharacters

final class MainPageViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        cancellables.removeAll()
    }
    
    func makeViewModel() -> MainPageViewModel {
        let networkService = NetworkService()
        let localDataService = LocalDataService()
        let apiDataTransferService = NetworkDataTransferService(networkService: networkService)
        let localDataTransferService = LocalDataTransferService(localService: localDataService)
        let repository = MainPageRepository(apiDataTransferService: apiDataTransferService,
                                            localDataTransferService: localDataTransferService)
        let useCases = MainPageUseCases(repository: repository)
        return MainPageViewModel(useCases: useCases)
    }
    
    func testMainPageListItems() throws {
        // GIVEN
        let viewModel = makeViewModel()
        let expectation = expectation(description: "testMainPageListItems")
        var items: [MainPageListItem] = []
        
        viewModel.$viewState
            .sink { state in
                switch state {
                case .ideal(let i):
                    items = i.characters
                    expectation.fulfill()
                default: break
                }
            }
            .store(in: &cancellables)
        
        // WHEN
        viewModel.load.send(())
        
        // THEN
        waitForExpectations(timeout: 3)
        XCTAssert(!items.isEmpty)
    }
    
    func testLoading() throws {
        // GIVEN
        let viewModel = makeViewModel()
        let expectation = expectation(description: "testLoading")
        var isLoading: [Bool] = []
        
        viewModel.$viewState
            .sink { state in
                switch state {
                case .loading:
                    isLoading.append(true)
                default:
                    isLoading.append(false)
                    expectation.fulfill()

                }
            }
            .store(in: &cancellables)
        
        // WHEN
        viewModel.load.send(())
        
        // THEN
        waitForExpectations(timeout: 3)
        
        XCTAssert(isLoading.first!)
        XCTAssertFalse(isLoading.last!)
    }

}
