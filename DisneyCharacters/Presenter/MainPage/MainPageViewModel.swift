//
//  MainPageViewModel.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation
import Combine

final class MainPageViewModel: ObservableObject {
    private let useCases: MainPageUseCasesType
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Input
    let load = PassthroughSubject<Void, Never>()
    let cellTap = PassthroughSubject<String, Never>()
    
    // MARK: - Output
    @Published var listItem: MainPageListViewItem?
    @Published var isLoading = false
    @Published var error: CustomError?
    
    init(useCases: MainPageUseCasesType) {
        self.useCases = useCases
        
        bindMainViewListItems()
        bindLoading()
    }
    
    private var characters: AnyPublisher<[Character], Error> {
        self.useCases.getCharacters(load: self.load, limit: 20)
    }
    
    private var favoriteIds: AnyPublisher<[Int], Error> {
        self.useCases.getFavoriteCharacterIds(key: UserDefaultsKey.favoriteCharacterKey).prepend([]).eraseToAnyPublisher()
    }
    
    private func bindMainViewListItems() {
        Publishers.CombineLatest(characters, favoriteIds)
            .map { (characters, favIds) -> MainPageListViewItem? in
                let items = characters.map {
                    MainPageListItem(id: $0.id, isFavorite: favIds.contains($0.id), title: $0.name, imageUrl: $0.imageUrl)
                }
                
                let fav = items.filter { !$0.isFavorite }
                let cha = items.filter { !$0.isFavorite }
                
                return MainPageListViewItem(favorites: fav, isFavoritesHidden: fav.isEmpty, characters: cha)
            }
            .catch({ [weak self] e -> AnyPublisher<MainPageListViewItem?, Never> in
                self?.error = CustomError.general(e)
                return .empty()
            })
            .assignNoRetain(to: \.listItem, on: self)
            .store(in: &cancellables)
    }
    
    private func bindLoading() {
        Publishers.Merge(self.load.map { _ in true },
                         Publishers.CombineLatest(characters, favoriteIds)
                            .map { _ in false }
                            .replaceError(with: false)
                            .throttle(for: 1, scheduler: DispatchQueue.main, latest: true))
        .assignNoRetain(to: \.isLoading, on: self)
        .store(in: &cancellables)
    }
    
    deinit {
        print("MainPageViewModel deinit")
    }
    
}
