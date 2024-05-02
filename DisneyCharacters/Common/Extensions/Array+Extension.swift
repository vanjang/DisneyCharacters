//
//  Array+Extension.swift
//  DisneyCharacters
//
//  Created by myung hoon on 02/05/2024.
//

import Foundation

extension Array where Element: Equatable {
    mutating func toggle(_ element: Element) {
        if let index = self.firstIndex(of: element) {
            self.remove(at: index)
        } else {
            self.append(element)
        }
    }
}
