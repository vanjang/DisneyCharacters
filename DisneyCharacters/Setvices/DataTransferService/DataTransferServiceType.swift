//
//  DataTransferServiceType.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation
import Combine

/// A protocol defining data transfer service types.
protocol DataTransferServiceType {
    /// Defining request for network data.
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
    /// Defining request for UserDefaults data
    func getUserDefaultsData<T>(key: String) -> AnyPublisher<T, Error>
    /// Defining request for UserDefault data update
    func updateUserDefaultsData<T>(data: T, key: String)
}

extension DataTransferServiceType {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> { .empty() }
    func getUserDefaultsData<T>(key: String) -> AnyPublisher<T, Error> { .empty() }
    func updateUserDefaultsData<T>(data: T, key: String) {}
}
