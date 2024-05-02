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
    @Published var viewState: ViewState<MainPageListViewItem> = .loading
    
    init(useCases: MainPageUseCasesType) {
        self.useCases = useCases
        
        bindViewState()
    }
    
    private var state: AnyPublisher<ViewState<MainPageListViewItem>, Never> {
        Publishers.CombineLatest(self.useCases.getCharacters(load: self.load, limit: 5),
                                 self.useCases.getFavoriteCharacterIds(key: UserDefaultsKey.favoriteCharacterKey).prepend([]))
            .map { (characters, favIds) in
                if characters.isEmpty {
                    return .empty
                } else {
                    let items = characters.map {
                        MainPageListItem(id: $0.id, isFavorite: favIds.contains($0.id), title: $0.name, imageUrl: $0.imageUrl)
                    }
//                    let fav = items.filter { $0.isFavorite }
                    let fav = items.filter { !$0.isFavorite }
                    let cha = items.filter { !$0.isFavorite }
                    return .ideal(MainPageListViewItem(favorites: fav, isFavoritesHidden: fav.isEmpty, characters: cha))
                }
            }
            .catch { error -> AnyPublisher<ViewState, Never> in
                Just(.error(error.localizedDescription)).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    private func bindViewState() {
        // because network response is being cached, 'state' can emit the value before 'load' and the order is not guaranteed. Therefore give a little of delay to 'state' in order to guarantee 'loading' is  emitted before 'state'.
        Publishers.Merge(self.load.map { _ in .loading },
                         self.state.delay(for: 0.5, scheduler: DispatchQueue.main)

        )
        .assignNoRetain(to: \.viewState, on: self)
        .store(in: &cancellables)
    }
    
    deinit {
        print("MainPageViewModel deinit")
    }
    
}
