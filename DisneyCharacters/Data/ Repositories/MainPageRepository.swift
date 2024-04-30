//
//  MainPageRepository.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation
import Combine

final class MainPageRepository {
    private let apiDataTransferService: DataTransferService
    
    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
}

extension MainPageRepository: MainPageRepositoryType {
    func fetchCharacters(load: PassthroughSubject<Void, Never>, limit: Int) -> AnyPublisher<[Character], Error> {
        load
            .paginate(limit: limit)
            .setFailureType(to: Error.self)
            .map { paginationItem -> MainPageEndopoint in
                let queryItems: [URLQueryItem] = [URLQueryItem(name: API.Queries.page.rawValue, value: "\(paginationItem.offset)"),
                                                  URLQueryItem(name: API.Queries.pageSize.rawValue, value: "\(paginationItem.limit)")]
                return MainPageEndopoint(path: API.Paths.character.rawValue, method: .get, parameters: queryItems)
            }
            .flatMapLatest { [unowned self] endpoint in
                let characters: AnyPublisher<Response<[Character]>, Error> = self.apiDataTransferService.request(endpoint: endpoint)
                return characters.map { $0.data }
            }
            .scan([Character](), { $0 + $1 })
            .eraseToAnyPublisher()
    }
}
