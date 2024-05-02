//
//  MainPageListItem.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

struct MainPageListItem: Identifiable {
    let id: Int
    let isFavorite: Bool
    let title: String
    let imageUrl: URL?
}

struct MainPageListViewItem {
    let favorites: [MainPageListItem]
    let isFavoritesHidden: Bool
    let characters: [MainPageListItem]
}
