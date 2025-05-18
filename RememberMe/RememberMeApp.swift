//
//  RememberMeApp.swift
//  RememberMe
//
//  Created by Richard Clarke on 16/05/2025.
//

import SwiftData
import SwiftUI

@main
struct RememberMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
