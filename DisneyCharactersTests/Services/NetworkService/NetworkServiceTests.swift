//
//  NetworkServiceTests.swift
//  DisneyCharactersTests
//
//  Created by myung hoon on 30/04/2024.
//

import XCTest
import Combine
@testable import DisneyCharacters

final class NetworkServiceTests: XCTestCase {
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }()
    
    private lazy var networkService = NetworkService(session: session)
    
    private lazy var mockJsonData: Data = {
        guard let resourceUrl = MockData.url, let data = try? Data(contentsOf: resourceUrl) else {
            XCTFail("Failed to create data object from string!")
            return Data()
        }
        return data
    }()
    
    private var endpoint: MockMainPageEndopoint {
        MockMainPageEndopoint(baseURL: MockData.url?.absoluteString ?? "")
    }
    
    private var cancellables: [AnyCancellable] = []

    override class func setUp() {
        URLProtocol.registerClass(URLProtocolMock.self)
    }
    
    func simulateRequest(endpoint: MockMainPageEndopoint) -> AnyPublisher<Result<Response<[Character]>, Error>, Never> {
       networkService.request(endpoint)
            .map { (response: Response<[Character]>) -> Result<Response<[Character]>, Error> in
                return .success(response)
            }
            .catch { error -> AnyPublisher<Result<Response<[Character]>, Error>, Never> in .just(.failure(error)) }
            .eraseToAnyPublisher()
    }
    
    func testLoadFinishedSuccessfully() {
        // GIVEN
        var result: Result<Response<[Character]>, Error>?
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: MockData.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, self.mockJsonData)
        }

        // WHEN
        simulateRequest(endpoint: endpoint)
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
        }).store(in: &cancellables)

        // THEN
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .success(let response) = result else {
            XCTFail()
            return
        }
        XCTAssert(!response.data.isEmpty)
    }

    func testLoadFailedWithError() {
        // GIVEN
        var result: Result<Response<[Character]>, Error>?
        let expectation = self.expectation(description: "networkServiceErrorExpectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: MockData.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        // WHEN
        simulateRequest(endpoint: endpoint)
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
        }).store(in: &cancellables)

        // THEN
        self.waitForExpectations(timeout: 1.0, handler: nil)
        
        guard case .failure(_) = result else {
            XCTFail()
            return
        }
    }

    func testLoadFailedWithJsonParsingError() {
        // GIVEN
        var result: Result<Response<[Character]>, Error>?
        let expectation = self.expectation(description: "networkServiceParsingErrorExpectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: MockData.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        // WHEN
        simulateRequest(endpoint: endpoint)
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
        }).store(in: &cancellables)

        // THEN
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .failure(let error) = result, error is DecodingError else {
            XCTFail()
            return
        }
    }
}
