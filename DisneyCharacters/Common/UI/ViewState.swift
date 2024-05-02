//
//  MainPageState.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import Foundation

enum ViewState<T> {
    case loading
    case empty
    case error(String)
    case ideal(T)
}
