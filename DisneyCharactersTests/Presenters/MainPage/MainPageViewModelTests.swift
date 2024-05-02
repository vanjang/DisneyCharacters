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
    
    func testMainPageListViewItem() throws {
        // GIVEN
        let viewModel = makeViewModel()
        let expectation = expectation(description: "testMainPageListViewItem")
        var item: MainPageListViewItem?
        
        viewModel.$listItem
            .sink { i in
                if let listItem = i {
                    item = listItem
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // WHEN
        viewModel.load.send(())
        
        // THEN
        waitForExpectations(timeout: 3)
        XCTAssert(item != nil)
    }
    
    func testLoading() throws {
        // GIVEN
        let viewModel = makeViewModel()
        let expectation = expectation(description: "testLoading")
        var loadingStates: [Bool] = []
        let loadingExpectation = [false, true, false]
        
        viewModel.$isLoading
            .sink { loading in
                loadingStates.append(loading)
                
                if loadingStates.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // WHEN
        viewModel.load.send(())
        waitForExpectations(timeout: 3)
        
        // THEN
        XCTAssertEqual(loadingStates, loadingExpectation)
    }
}
