//
//  RetrospectiveApp.swift
//  Retrospective
//
//  Created by 김건우 on 5/11/25.
//

import SwiftUI
import SwiftData

@main
struct RetrospectiveApp: App {
    let persistenceManager = PersistenceManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .dynamicTypeSize(.small ... .xxxLarge)
        }
        .modelContainer(PersistenceManager.previewContainer)
    }
}
