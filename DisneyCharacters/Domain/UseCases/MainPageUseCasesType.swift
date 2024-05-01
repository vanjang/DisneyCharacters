//
//  MainPageUseCasesType.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

protocol MainPageUseCasesType {
    func getCharacters(load: PassthroughSubject<Void, Never>, limit: Int) -> AnyPublisher<[Character], Error>
    func getFavoriteCharacterIds() -> AnyPublisher<[Int], Error>
}

final class MainPageUseCases: MainPageUseCasesType {
    private let repository: MainPageRepositoryType
    
    init(repository: MainPageRepositoryType) {
        self.repository = repository
    }
    
    func getCharacters(load: PassthroughSubject<Void, Never>, limit: Int) -> AnyPublisher<[Character], Error> {
        self.repository.fetchCharacters(load: load, limit: limit)
    }
    
    func getFavoriteCharacterIds() -> AnyPublisher<[Int], Error> {
        repository.fetchFavoriteCharacterIds()
    }
}
