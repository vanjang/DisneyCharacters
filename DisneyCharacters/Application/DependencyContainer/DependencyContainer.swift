//
//  DependencyContainer.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

class DependencyContainer: ObservableObject {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let localDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension DependencyContainer {
    var mainPageRepository: MainPageRepositoryType {
        MainPageRepository(apiDataTransferService: dependencies.apiDataTransferService,
                           localDataTransferService: dependencies.localDataTransferService)
    }
    
    var mainPageUseCases: MainPageUseCasesType {
        MainPageUseCases(repository: mainPageRepository)
    }
    
    var mainPageViewModel: MainPageViewModel {
        MainPageViewModel(useCases: mainPageUseCases)
    }
    
    var mainPageView: MainPageView {
        MainPageView(viewModel: mainPageViewModel)
    }
}
