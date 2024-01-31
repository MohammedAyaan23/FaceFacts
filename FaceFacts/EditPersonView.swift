//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Mohammed Ayaan on 07/01/24.
//
import SwiftData
import SwiftUI
import PhotosUI

struct EditPersonView: View {
    @State private var selectedItem: PhotosPickerItem?
    @Environment(\.modelContext) var modelContext
    @Bindable var person : Person
    @Binding var navigationPath: NavigationPath
    @Query (sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events : [Event]
    var body: some View {
        Form{
            Section{
                if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images){
                    Label("Add a Photo", systemImage: "person")
                }
            }
            Section{
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                TextField("Email Address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
            }
            Section("Where did you met them"){
                Picker("Met at", selection: $person.metAt){
                    Text("Unknown Event")
                        .tag(Optional<Event>.none)
                    
                    if events.isEmpty == false {
                        Divider()
                        ForEach(events) { event in
                            Text(event.name)
                                .tag(Optional(event))
                            
                        }
                    }
                }
            }
            Section("Notes"){
                TextField("Details about htis Person", text: $person.details, axis: .vertical)
            }
            
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationDestination(for: Event.self) { event in
            EditEventView(event: event)
        }
        .onChange(of:selectedItem,loadPhoto)
    }
    
    func addEvent() {
         let newEvent = Event(name: "", location: "")
        modelContext.insert(newEvent)
        navigationPath.append(newEvent)
    }
    func loadPhoto() {
        Task{@MainActor in
            person.photo = try await selectedItem?.loadTransferable(type: Data.self)
            
        }
    }
    
}

#Preview {
    do{
        let previewer = try Previewer()
        return EditPersonView(person: previewer.person, navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch{
        return Text("Failed to create Preview \(error.localizedDescription)")
    }
}
