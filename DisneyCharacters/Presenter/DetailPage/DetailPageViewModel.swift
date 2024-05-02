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
    @Published var viewState: ViewState<DetailPageItem> = .loading
    
    init(id: Int, useCases: DetailPageUseCasesType) {
        self.useCases = useCases
        self.id = id
        
        bindCharacterDetail()
        bindUpdateFavoriteCharacterIds()
    }
    
    private var character: AnyPublisher<Character, Error> {
        self.useCases.getCharacter(id: id)
    }
    
    private var favoriteCharacterIds: AnyPublisher<[Int], Error> {
        self.useCases.getFavoriteCharacterIds(with: UserDefaultsKey.favoriteCharacterKey)
    }
    
    private func bindCharacterDetail() {
        Publishers.CombineLatest(character, favoriteCharacterIds)
        .map { (character, favoriteIds) -> ViewState in
                .ideal(DetailPageItem(id: character.id,title: character.name, imageUrl: character.imageUrl, isFavorite: favoriteIds.contains(character.id)))
        }
        .catch { error -> AnyPublisher<ViewState, Never> in
            Just(.error(error.localizedDescription)).eraseToAnyPublisher()
        }
        .assignNoRetain(to: \.viewState, on: self)
        .store(in: &cancellables)
    }
    
    private func bindUpdateFavoriteCharacterIds() {
        didTapButton
            .setFailureType(to: Error.self)
            .combineLatest(favoriteCharacterIds) { $1 }
            .map { [unowned self] favIds -> ([Int], String) in
                var ids = favIds
                ids.toggle(self.id)
                return (ids, UserDefaultsKey.favoriteCharacterKey)
            }
            .sink(receiveCompletion: { _ in }, receiveValue: useCases.updateFavoriteCharacter)
            .store(in: &cancellables)
    }
    
    deinit {
        print("DetailPageViewModel deinit")
    }
}
