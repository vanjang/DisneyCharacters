//
//  LocalDataService.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

protocol LocalDataServiceType {
    var favoriteCharacterIds: [Int] { get }
    func addFavoriteCharacter(id: Int)
    func removeFavoriteCharacter(id: Int)
}

final class LocalDataService: LocalDataServiceType {
    private let favoriteCharacters = UserFavoriteCharacters()
    
    func addFavoriteCharacter(id: Int) {
        favoriteCharacters.addFavoriteCharacter(id: id)
    }
    
    func removeFavoriteCharacter(id: Int) {
        favoriteCharacters.removeFavoriteCharacter(id: id)
    }
    
    var favoriteCharacterIds: [Int] {
        favoriteCharacters.currentFavoriteCharacterIds
    }
}

fileprivate struct UserDefaultsKey {
    static let favoriteCharacterKey = "favoriteCharacter"
}

fileprivate class UserFavoriteCharacters {
    var currentFavoriteCharacterIds: [Int] {
        UserDefaults.standard.array(forKey: UserDefaultsKey.favoriteCharacterKey) as? [Int] ?? []
    }
    
    func addFavoriteCharacter(id: Int) {
        UserDefaults.standard.set(currentFavoriteCharacterIds + [id], forKey: UserDefaultsKey.favoriteCharacterKey)
    }
    
     func removeFavoriteCharacter(id: Int) {
        var currentIds = currentFavoriteCharacterIds
         if let index = currentIds.firstIndex(of: id) {
             currentIds.remove(at: index)
             UserDefaults.standard.set(currentIds, forKey: UserDefaultsKey.favoriteCharacterKey)
         }
    }
}
