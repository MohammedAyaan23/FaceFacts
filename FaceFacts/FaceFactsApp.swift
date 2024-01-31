//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Mohammed Ayaan on 07/01/24.
//

import SwiftUI
import SwiftData

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
