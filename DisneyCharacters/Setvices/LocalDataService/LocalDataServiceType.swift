//
//  LocalDataServiceType.swift
//  DisneyCharacters
//
//  Created by myung hoon on 03/05/2024.
//

import Combine

protocol LocalDataServiceType {
    func getData<T>(key: String) -> AnyPublisher<T, Error>
    func update<T>(data: T, key: String)
}
