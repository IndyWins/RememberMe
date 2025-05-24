//
//  DetailView.swift
//  RememberMe
//
//  Created by Richard Clarke on 18/05/2025.
//

import MapKit
import PhotosUI
import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let user: User
    
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        VStack {
            Form {
                Section("Contact Name") {
                    Text(user.name)
                }
                
                Section("Photo") {
                    if let userImage = user.image {
                        userImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("No Image Available")
                    }
                }
                
                
                
                Section("Where we met...") {
                    MapReader { proxy in
                        Map(initialPosition:
                                MapCameraPosition.region(
                                    MKCoordinateRegion(center: user.coordinate,
                                                       span: MKCoordinateSpan(
                                                        latitudeDelta: 0.02,
                                                        longitudeDelta: 0.02))),
                            interactionModes: [ ] ) {
                            Annotation(user.name, coordinate: user.coordinate) {
                                Image(systemName: "pin.fill")
                                    .resizable()
                                    .foregroundStyle(.red)
                            }
                        }
                        .frame(height:150)
                    }
                }
                
                Section("Additional Info:") {
                    Text(user.notes)
                }
                
                Section {
                    Button(role: .destructive) {
                        showDeleteConfirmation = true
                    } label: {
                        Label("Delete Contact", systemImage: "trash")
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .alert("Are you sure?", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive, action: deleteUser)
        }
    }
    
    func deleteUser() {
        modelContext.delete(user)
        dismiss()
    }
}

#Preview {
    let sampleUser = User(id: UUID(), name: "Eren", notes: "The Attack Titan", photo: UIImage(named: "Eren")?.jpegData(compressionQuality: 1.0), latitude: 52, longitude: -2)
    NavigationStack {
        DetailView(user: sampleUser)
    }
}

