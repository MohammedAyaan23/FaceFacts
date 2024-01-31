//
//  ContentView.swift
//  FaceFacts
//
//  Created by Mohammed Ayaan on 07/01/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    @State private var sortOrder = [SortDescriptor(\Person.name)]
    @State private var searchText = ""
    var body: some View {
        NavigationStack(path: $path){
           PeopleView(searchString: searchText,sortOrder: sortOrder)
            .navigationTitle("FaceFActs")
            .navigationDestination(for: Person.self) { person in
                EditPersonView(person: person, navigationPath: $path)
            }
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder){
                        Text("Name - (A->Z)")
                            .tag([SortDescriptor(\Person.name)])
                        Text("Name - (Z->A)")
                            .tag([SortDescriptor(\Person.name, order:.reverse)])
                    }
                    
                }
                Button("Add Person", systemImage: "plus", action: addPerson)
            }
            .searchable( text: $searchText)
        }
    }
    
    func addPerson() {
        let newPerson = Person(name: "", emailAddress: "", details: "")
        modelContext.insert(newPerson)
        path.append(newPerson)
    }
    
        
    
}

#Preview {
    ContentView()
}
