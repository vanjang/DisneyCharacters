//
//  AppDependencyContainer.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

struct AppDependencyContainer {
    func makeAppDependenciesContainer() -> DependencyContainer {
        let services = DependencyContainer.DataTransferServices(apiDataTransferService: NetworkDataTransferService(networkService: NetworkService()),
                                                                localDataTransferService: LocalDataTransferService(localService: LocalDataService()))
        return DependencyContainer(dataTransferServices: services)
    }
}
