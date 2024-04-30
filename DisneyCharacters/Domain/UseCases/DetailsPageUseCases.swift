//
//  DetailsPageUseCases.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

protocol DetailsPageUseCasesType {
    func getCharacter() -> AnyPublisher<Character, Error>
}

final class DetailsPageUseCases: DetailsPageUseCasesType {
    private let repository: DetailPageRepositoryType
    
    init(repository: DetailPageRepositoryType) {
        self.repository = repository
    }
    
    func getCharacter() -> AnyPublisher<Character, Error> {
        self.repository.fetchCharacter()
    }
}
