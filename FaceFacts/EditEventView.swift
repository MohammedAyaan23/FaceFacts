//
//  EditEventView.swift
//  FaceFacts
//
//  Created by Mohammed Ayaan on 07/01/24.
//

import SwiftUI

struct EditEventView: View {
    @Bindable var event: Event
    var body: some View {
        Form{
            TextField("Event NAme", text: $event.name)
            TextField("Location", text: $event.location)
        }
        .navigationTitle("Edit Event")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

#Preview {
    do{
        let previewer = try Previewer()
        return EditEventView(event: previewer.event)
            .modelContainer(previewer.container)
    } catch{
        return Text("Failed to create Preview \(error.localizedDescription)")
    }
}
