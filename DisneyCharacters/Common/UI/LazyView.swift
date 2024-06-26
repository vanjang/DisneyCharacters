//
//  LazyView.swift
//  DisneyCharacters
//
//  Created by myung hoon on 02/05/2024.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
