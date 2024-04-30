//
//  DataTransferService.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

protocol DataTransferService {
    func request<T: Decodable>() -> AnyPublisher<T, Error>
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

extension DataTransferService {
    func request<T: Decodable>() -> AnyPublisher<T, Error> { Empty().eraseToAnyPublisher() }
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> { Empty().eraseToAnyPublisher() }
}
