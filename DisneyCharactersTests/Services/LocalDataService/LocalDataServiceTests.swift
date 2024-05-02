//
//  LocalDataServiceTests.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 01/05/2024.
//

import XCTest
import Combine
@testable import DisneyCharacters

class LocalDataServiceTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    let localDataService: LocalDataServiceType = LocalDataService()
    let testKey = "testKey"
    
    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
        UserDefaults.standard.removeObject(forKey: testKey)
    }
    
    func testGetData() throws {
        let testValue = [0, 1, 2]
        UserDefaults.standard.set(testValue, forKey: testKey)
        
        let expectation = XCTestExpectation(description: "testGetData")
        
        localDataService.getData(key: testKey)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Received error: \(error)")
                }
            }, receiveValue: { value in
                XCTAssertEqual(value, testValue)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testUpdateData() throws {
        let testValue = [0, 1, 2]
        
        let expectation = XCTestExpectation(description: "testUpdateData")
        
        localDataService.update(data: testValue, key: testKey)
        
        localDataService.getData(key: testKey)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Received error: \(error)")
                }
            }, receiveValue: { value in
                XCTAssertEqual(value, testValue)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
