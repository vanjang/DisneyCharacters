//
//  DependencyContainer.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

class DependencyContainer: ObservableObject {
    struct Dependencies {
        let apiDataTransferService: DataTransferServiceType
        let localDataTransferService: DataTransferServiceType
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - Main page dependencies
extension DependencyContainer {
    func mainPageRepository() -> MainPageRepositoryType {
        MainPageRepository(apiDataTransferService: dependencies.apiDataTransferService,
                           localDataTransferService: dependencies.localDataTransferService)
    }
    
    func mainPageUseCases() -> MainPageUseCasesType {
        MainPageUseCases(repository: mainPageRepository())
    }
    
    func mainPageViewModel() -> MainPageViewModel {
        MainPageViewModel(useCases: mainPageUseCases())
    }
    
    func mainPageView() -> MainPageView {
        MainPageView(viewModel: mainPageViewModel())
    }
}

// MARK: - Detail page dependencies
extension DependencyContainer {
    func detailPageRepository() -> DetailPageRepositoryType {
        DetailPageRepository(apiDataTransferService: dependencies.apiDataTransferService,
                             localDataTransferService: dependencies.localDataTransferService)
    }
    
    func detailPageUseCases() -> DetailPageUseCasesType {
        DetailPageUseCases(repository: detailPageRepository())
    }
    
    func detailPageViewModel(id: Int) -> DetailPageViewModel {
        DetailPageViewModel(id: id, useCases: detailPageUseCases())
    }
    
    func detailPageView(id: Int) -> DetailPageView {
        DetailPageView(viewModel: detailPageViewModel(id: id))
    }
}
