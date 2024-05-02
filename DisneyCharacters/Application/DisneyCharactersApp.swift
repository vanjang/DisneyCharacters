//
//  DisneyCharactersApp.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import SwiftUI

@main
struct DisneyCharactersApp: App {
    let appDependencyContainer = AppDependencyContainer()
    var dependencies: DependencyContainer {
        appDependencyContainer.makeAppDependenciesContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            dependencies.mainPageView()
                .environmentObject(dependencies)
        }
    }
}
