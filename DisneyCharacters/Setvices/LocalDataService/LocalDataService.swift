//
//  LocalDataService.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

struct LocalDataService: LocalDataServiceType {
    func getData<T>(key: String) -> AnyPublisher<T, Error> {
        UserDefaultsStorage<T>.getData(for: key)
    }
    
    func update<T>(data: T, key: String) {
        UserDefaultsStorage<T>.update(data: data, for: key)
    }
}
