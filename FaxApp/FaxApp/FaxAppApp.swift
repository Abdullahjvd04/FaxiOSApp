//
//  FaxAppApp.swift
//  FaxApp
//
//  Created by Ios Dev on 23/02/2026.
//

import SwiftUI

@main
struct FaxAppApp: App {
    @StateObject private var languageManager = LanguageManager()

    var body: some Scene {
        WindowGroup {
//            ContentView()
//            SettingsView()
            RootView()
                             .environmentObject(languageManager)
                               .environment(\.locale, languageManager.locale)
        }
    }
}
