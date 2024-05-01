//
//  DataTransferService.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

/// A protocol defining data transfer service types.
protocol DataTransferService {
    /// Defining request for local data.
    func request<T>() -> AnyPublisher<T, Error>
    /// Defining request for network data.
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

extension DataTransferService {
    func request<T>() -> AnyPublisher<T, Error> { Empty().eraseToAnyPublisher() }
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> { Empty().eraseToAnyPublisher() }
}
