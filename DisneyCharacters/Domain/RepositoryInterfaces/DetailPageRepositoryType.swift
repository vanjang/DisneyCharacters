//
//  DetailPageRepositoryType.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation
import Combine

protocol DetailPageRepositoryType {
    func fetchCharacter(id: Int) -> AnyPublisher<Character, Error>
    func fetchFavoriteCharacterIds(with key: String) -> AnyPublisher<[Int], Error>
    func editFavoriteCharacter(ids: [Int], key: String)
}
