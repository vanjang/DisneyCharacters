//
//  MainPageRepository.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation
import Combine

final class MainPageRepository {
    private let apiDataTransferService: DataTransferServiceType
    private let localDataTransferService: DataTransferServiceType
    
    init(apiDataTransferService: DataTransferServiceType, localDataTransferService: DataTransferServiceType) {
        self.apiDataTransferService = apiDataTransferService
        self.localDataTransferService = localDataTransferService
    }
}

extension MainPageRepository: MainPageRepositoryType {
    func fetchCharacters(load: PassthroughSubject<Void, Never>, limit: Int) -> AnyPublisher<[Character], Error> {
        load
            .paginate(limit: limit)
            .setFailureType(to: Error.self)
            .map { paginationItem -> DisneyAPIEndopoint in
                let queryItems: [URLQueryItem] = [URLQueryItem(name: API.Queries.page.rawValue, value: "\(paginationItem.offset)"),
                                                  URLQueryItem(name: API.Queries.pageSize.rawValue, value: "\(paginationItem.limit)")]
                return DisneyAPIEndopoint(path: API.Paths.character.rawValue, method: .get, parameters: queryItems)
            }
            .flatMap { [unowned self] endpoint in
                let response: AnyPublisher<Response<[Character]>, Error> = self.apiDataTransferService.request(endpoint: endpoint)
                return response.map { $0.data }
            }
            .scan([Character](), { $0 + $1 })
            .eraseToAnyPublisher()
    }
    
    func fetchFavoriteCharacterIds(key: String) -> AnyPublisher<[Int], Error> {
        localDataTransferService.getUserDefaultsData(key: key)
    }
}
