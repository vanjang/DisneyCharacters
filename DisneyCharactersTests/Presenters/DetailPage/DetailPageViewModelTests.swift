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
    
    func testDetailPageItem() throws {
        // GIVEN
        let id = 12
        let viewModel = makeViewModel(id: id)
        let expectation = expectation(description: "testDetailPageItem")
        var item: DetailPageItem!
        
        viewModel.$item
            .compactMap { $0 }
            .sink { i in
                item = i
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // WHEN
        waitForExpectations(timeout: 2)
        
        // THEN
        XCTAssert(item != nil)
    }
    
    func testLoading() throws {
        // GIVEN
        let id = 12
        let viewModel = makeViewModel(id: id)
        let expectation = expectation(description: "testLoading")
        var loadingStates: [Bool] = []
        let loadingExpectation = [true, true, false]
        
        viewModel.$isLoading
            .sink { loading in
                loadingStates.append(loading)
                
                if loadingStates.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // WHEN
        viewModel.didTapButton.send(())
        waitForExpectations(timeout: 3)
        
        // THEN
        XCTAssertEqual(loadingStates, loadingExpectation)
    }
    
    func testError() throws {
        // GIVEN
        let id = 10000000000// wrong id to procude error
        let viewModel = makeViewModel(id: id)
        let expectation = expectation(description: "testError")
        var error: CustomError!
        
        viewModel.$error
            .compactMap { $0 }
            .sink { e in
                error = e
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // WHEN
        waitForExpectations(timeout: 1)
        
        // THEN
        XCTAssert(error != nil)
    }
}
