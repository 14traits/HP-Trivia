//
//  HP_TriviaApp.swift
//  HP Trivia
//
//  Created by John Rogers on 1/9/25.
//

import SwiftUI

@main
struct HP_TriviaApp: App {
    @StateObject private var store = Store()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .task{
                    await store.LoadProducts()
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
