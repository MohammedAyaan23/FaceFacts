//
//  Previewer.swift
//  FaceFacts
//
//  Created by Mohammed Ayaan on 07/01/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let person: Person
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Person.self, configurations: config)
        
        event = Event(name: "Dimension Jump", location: "Hyderabad")
        person = Person(name: "Ayaan", emailAddress: "sdbfjhs@gmail.com", details: "No Details", metAt: event)
        container.mainContext.insert(person)
    }
}
