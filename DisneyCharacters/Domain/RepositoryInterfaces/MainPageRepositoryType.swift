//
//  MainPageRepositoryType.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

protocol MainPageRepositoryType {
    func fetchCharacters(load: PassthroughSubject<Void, Never>, limit: Int) -> AnyPublisher<[Character], Error>
    func fetchFavoriteCharacterIds(key: String) -> AnyPublisher<[Int], Error>
}
