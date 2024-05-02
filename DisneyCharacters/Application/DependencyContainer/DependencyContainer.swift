//
//  DependencyContainer.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

class DependencyContainer: ObservableObject {
    struct DataTransferServices {
        let apiDataTransferService: DataTransferServiceType
        let localDataTransferService: DataTransferServiceType
    }
    
    private let dataTransferServices: DataTransferServices
    
    init(dataTransferServices: DataTransferServices) {
        self.dataTransferServices = dataTransferServices
    }
}

// MARK: - Main page dependencies
extension DependencyContainer {
    func mainPageRepository() -> MainPageRepositoryType {
        MainPageRepository(apiDataTransferService: dataTransferServices.apiDataTransferService,
                           localDataTransferService: dataTransferServices.localDataTransferService)
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
        DetailPageRepository(apiDataTransferService: dataTransferServices.apiDataTransferService,
                             localDataTransferService: dataTransferServices.localDataTransferService)
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
