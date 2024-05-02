//
//  DetailPageUseCasesType.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation
import Combine

protocol DetailPageUseCasesType {
    func getCharacter(id: Int) -> AnyPublisher<Character, Error>
    func getFavoriteCharacterIds(with key: String) -> AnyPublisher<[Int], Error>
    func updateFavoriteCharacter(ids: [Int], key: String)
}

final class DetailPageUseCases: DetailPageUseCasesType {
    private let repository: DetailPageRepositoryType
    
    init(repository: DetailPageRepositoryType) {
        self.repository = repository
    }
    
    func getCharacter(id: Int) -> AnyPublisher<Character, Error> {
        self.repository.fetchCharacter(id: id)
    }
    
    func getFavoriteCharacterIds(with key: String) -> AnyPublisher<[Int], Error> {
        self.repository.fetchFavoriteCharacterIds(with: key)
    }
    
    func updateFavoriteCharacter(ids: [Int], key: String) {
        self.repository.editFavoriteCharacter(ids: ids, key: key)
    }
}
