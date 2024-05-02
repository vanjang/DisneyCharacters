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

extension LocalDataTransferService: DataTransferServiceType {
    func getUserDefaultsData<T>(key: String) -> AnyPublisher<T, Error> {
        localService.getData(key: key)
    }
    
    func updateUserDefaultsData<T>(data: T, key: String) {
        localService.update(data: data, key: key)
    }
}
