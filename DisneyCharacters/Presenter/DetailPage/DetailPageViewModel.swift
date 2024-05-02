//
//  DetailPageViewModel.swift
//  DisneyCharacters
//
//  Created by myung hoon on 01/05/2024.
//

import Foundation
import Combine

final class DetailPageViewModel: ObservableObject {
    private let useCases: DetailPageUseCasesType
    private var cancellables: Set<AnyCancellable> = []
    private let id: Int
    
    // MARK: - Input
    let didTapButton = PassthroughSubject<Void, Never>()
    
    // MARK: - Output
    @Published private(set) var item: DetailPageItem?
    @Published private(set) var error: CustomError?
    @Published private(set) var isLoading = false
    
    init(id: Int, useCases: DetailPageUseCasesType) {
        self.useCases = useCases
        self.id = id
        
        bindDetailPageItem()
        bindLoading()
        bindUpdateFavoriteCharacterIds()
    }
    
    private var character: AnyPublisher<Character, Error> {
        self.useCases.getCharacter(id: id)
    }
    
    private var favoriteIds: AnyPublisher<[Int], Error> {
        self.useCases.getFavoriteCharacterIds(with: UserDefaultsKey.favoriteCharacterKey).prepend([]).eraseToAnyPublisher()
    }
    
    private func bindDetailPageItem() {
        Publishers.CombineLatest(character, favoriteIds)
            .map { (character, favoriteIds) -> DetailPageItem? in
                DetailPageItem(id: character.id,title: character.name, imageUrl: character.imageUrl, isFavorite: favoriteIds.contains(character.id))
            }
            .catch { [weak self] e -> AnyPublisher<DetailPageItem?, Never> in
                self?.error = .general(e)
                return .empty()
            }
            .assignNoRetain(to: \.item, on: self)
            .store(in: &cancellables)
    }
    
    private func bindUpdateFavoriteCharacterIds() {
        didTapButton
            .combineLatest(favoriteIds.replaceError(with: [])) { $1 }
            .map { [unowned self] favIds -> ([Int], String) in
                var ids = favIds
                ids.toggle(self.id)
                return (ids, UserDefaultsKey.favoriteCharacterKey)
            }
            .sink(receiveCompletion: { _ in }, receiveValue: useCases.updateFavoriteCharacter)
            .store(in: &cancellables)
    }
    
    private func bindLoading() {
        Publishers.Merge3(Just(true),
                          didTapButton.map { _ in true },
                          Publishers.CombineLatest(character, favoriteIds)
                            .map { _ in false }
                            .replaceError(with: false)
                            .throttle(for: 1, scheduler: DispatchQueue.main, latest: true))
        .assignNoRetain(to: \.isLoading, on: self)
        .store(in: &cancellables)
    }
    
    deinit {
        print("DetailPageViewModel deinit")
    }
}
