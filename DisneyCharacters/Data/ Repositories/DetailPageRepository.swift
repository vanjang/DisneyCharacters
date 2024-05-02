//
//  DetailPageRepository.swift
//  DisneyCharacters
//
//  Created by myung hoon on 01/05/2024.
//

import Foundation
import Combine

final class DetailPageRepository {
    private let apiDataTransferService: DataTransferServiceType
    private let localDataTransferService: DataTransferServiceType
    
    init(apiDataTransferService: DataTransferServiceType, localDataTransferService: DataTransferServiceType) {
        self.apiDataTransferService = apiDataTransferService
        self.localDataTransferService = localDataTransferService
    }
}

extension DetailPageRepository: DetailPageRepositoryType {
    func fetchCharacter(id: Int) -> AnyPublisher<Character, Error> {
        let endpoint = DisneyAPIEndopoint(path: "\(API.Paths.character.rawValue)/\(id)", method: .get)
        let response: AnyPublisher<Response<Character>, Error> = apiDataTransferService.request(endpoint: endpoint)
        let character = response.map { $0.data }
        return character.eraseToAnyPublisher()
    }
    
    func fetchFavoriteCharacterIds(with key: String) -> AnyPublisher<[Int], Error> {
        localDataTransferService.getUserDefaultsData(key: key)
    }
    
    func editFavoriteCharacter(ids: [Int], key: String) {
        localDataTransferService.updateUserDefaultsData(data: ids, key: key)
    }
}
