//
//  HP_TriviaApp.swift
//  HP Trivia
//
//  Created by John Rogers on 1/9/25.
//

import SwiftUI

@main
struct HP_TriviaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
