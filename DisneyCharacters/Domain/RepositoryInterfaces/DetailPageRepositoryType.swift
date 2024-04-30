//
//  DetailPageRepositoryType.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

protocol DetailPageRepositoryType {
    func fetchCharacter() -> AnyPublisher<Character, Error>
}
