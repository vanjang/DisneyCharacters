//
//  Publisher+Extension.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation
import Combine

// MARK: - FlatMapLatest
extension Publisher {
    func flatMapLatest<T: Publisher>(_ transform: @escaping (Self.Output) -> T) -> Publishers.SwitchToLatest<T, Publishers.Map<Self, T>> where T.Failure == Self.Failure {
        map(transform).switchToLatest()
    }
    
    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty().eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }

    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error).eraseToAnyPublisher()
    }
}

// MARK: - Cache
extension Publisher where Output == (data: Data, response: URLResponse), Failure == URLError {
    func cache<T: Decodable>(using cache: URLCache, for request: URLRequest, with type: T.Type, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
        return map { (data, response) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
                cache.storeCachedResponse(cachedResponse, for: request)
            }
            return data
        }
        .decode(type: T.self, decoder: decoder)
        .eraseToAnyPublisher()
    }
}

// MARK: - Pagination
extension Publisher where Failure == Never {
    typealias PaginationItem = (limit: Int, offset: Int)
    func paginate(limit: Int) -> AnyPublisher<PaginationItem, Never> {
        scan(PaginationItem(limit: 0, offset: 0)) { last, _ in PaginationItem(limit: limit, offset: last.offset + limit) }
            .eraseToAnyPublisher()
    }
}
