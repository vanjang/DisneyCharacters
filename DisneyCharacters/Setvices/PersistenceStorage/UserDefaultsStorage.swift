//
//  UserDefaultsStorage.swift
//  DisneyCharacters
//
//  Created by myung hoon on 02/05/2024.
//

import Foundation
import Combine

struct UserDefaultsKey {
    static let favoriteCharacterKey = "favoriteCharacter"
}

extension UserDefaults {
    func publisher<T>(for key: String) -> AnyPublisher<T, Error> {
        Publishers.Merge(Just(UserDefaults.standard.value(forKey: key) as? T).compactMap { $0 },
                         NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)
                            .compactMap { notification in
                                (notification.object as? UserDefaults)?.value(forKey: key) as? T
                            })
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

final class UserDefaultsStorage<T>: ObservableObject {
    static func getData<T>(for key: String) -> AnyPublisher<T, Error> {
        UserDefaults.standard.publisher(for: key)
    }

    static func update(data: T, for key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
}
