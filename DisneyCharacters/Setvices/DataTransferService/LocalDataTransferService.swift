//
//  LocalDataTransferService.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

final class LocalDataTransferService {
    private let localService: LocalDataServiceType

    init(localService: LocalDataServiceType) {
        self.localService = localService
    }
}

extension LocalDataTransferService: DataTransferService {
    func request<T>() -> AnyPublisher<T, Error> {
        Just(localService.favoriteCharacterIds as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
