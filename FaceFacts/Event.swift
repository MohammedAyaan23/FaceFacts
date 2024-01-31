//
//  Event.swift
//  FaceFacts
//
//  Created by Mohammed Ayaan on 07/01/24.
//

import Foundation
import SwiftData
@Model
class Event {
    var name: String
    var location: String
    var people = [Person]()
    
    init(name: String, location: String, people: [Person] = [Person]()) {
        self.name = name
        self.location = location
        self.people = people
    }
}
