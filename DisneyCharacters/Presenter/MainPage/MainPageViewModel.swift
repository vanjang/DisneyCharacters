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
    let sortTap = PassthroughSubject<SortType, Never>()
    
    // MARK: - Output
    @Published private(set) var listItem: MainPageListViewItem?
    @Published private(set) var isLoading = false
    @Published private(set) var error: CustomError?
    @Published private(set) var sortTypes: [SortType] = [.films, .shortFilms]
    
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
        Publishers.CombineLatest3(characters, favoriteIds, sortTap.prepend(.films).setFailureType(to: Error.self))
            .map (createItem)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assignNoRetain(to: \.listItem, on: self)
            .store(in: &cancellables)
    }
    
    private func bindLoading() {
        Publishers.Merge(load.map { _ in true },
                         Publishers.CombineLatest(characters, favoriteIds)
                            .map { _ in false }
                            .replaceError(with: false)
                            .throttle(for: 1, scheduler: DispatchQueue.main, latest: true))
        .receive(on: DispatchQueue.main)
        .assignNoRetain(to: \.isLoading, on: self)
        .store(in: &cancellables)
    }
    
    private func sortedCharacters(characters: [Character], sortType: SortType) -> [Character] {
        characters.sorted { c1, c2 in
            switch sortType {
            case .films: return c1.films.count > c2.films.count
            case .shortFilms: return c1.shortFilms.count > c2.shortFilms.count
            }
        }
    }
    
    private func createItem(characters: [Character], favoriteIds: [Int], sortType: SortType) -> MainPageListViewItem? {
        let items = sortedCharacters(characters: characters, sortType: sortType).map {
            MainPageListItem(id: $0.id, isFavorite: favoriteIds.contains($0.id), title: $0.name, imageUrl: URL(string: $0.imageUrl ?? ""))
        }
        
        let fav = items.filter { $0.isFavorite }

        return MainPageListViewItem(favorites: fav, isFavoritesHidden: fav.isEmpty, characters: items)
    }
    
    deinit {
        print("MainPageViewModel deinit")
    }
    
}
