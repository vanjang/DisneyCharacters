//
//  MainUseCases.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Combine

protocol MainUseCasesType {
    func getCharacters() -> AnyPublisher<[Character], Error>
}

final class MainUseCases: MainUseCasesType {
    func getCharacters() -> AnyPublisher<[Character], Error> {
        <#code#>
    }
}
