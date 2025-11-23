//
//  TOEICPrepApp.swift
//  TOEICPrep
//

import SwiftUI
import SwiftData

@main
struct TOEICPrepApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Question.self)
    }
}
