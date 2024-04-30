//
//  NetworkServiceType.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

/// Protocol defining the requirements for a network service.
protocol NetworkServiceType {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error>
}

