//
//  MainPageDataTransferService.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

final class MainPageDataTransferService {
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
}

extension MainPageDataTransferService: DataTransferService {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        networkService.request(endpoint).eraseToAnyPublisher()
    }
}
