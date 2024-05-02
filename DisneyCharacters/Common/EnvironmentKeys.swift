//
//  EnvironmentKeys.swift
//  DisneyCharacters
//
//  Created by myung hoon on 02/05/2024.
//

import SwiftUI

struct HorizontalViewHeight: EnvironmentKey {
    static var defaultValue: CGFloat = 100
}

extension EnvironmentValues {
    var horizontalViewHeight: CGFloat {
        get { self[HorizontalViewHeight.self] }
        set { self[HorizontalViewHeight.self] = newValue }
    }
}
