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

    @AppStorage(\.hasLoadedInitialData) private var hasLoadedInitialData: Bool
    @AppStorage(\.hasCompletedOnboarding) private var hasCompletedOnboarding: Bool
    @State private var isShowingOnboarding: Bool = false
    let persistenceManager = PersistenceManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if !hasCompletedOnboarding {
                        isShowingOnboarding = true
                        hasCompletedOnboarding = true
                    }

                    if !hasLoadedInitialData {
                        persistenceManager.createInitialCategories {
                            hasLoadedInitialData = true
                        }
                    }
                }
                .sheet(isPresented: $isShowingOnboarding) {
                    OnboardingView()
                }
                .dynamicTypeSize(.small ... .xxxLarge)
        }
        .modelContext(persistenceManager.mainContext)
//        .modelContainer(PersistenceManager.previewContainer)
    }
}

