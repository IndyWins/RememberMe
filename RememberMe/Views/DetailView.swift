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
            }
        }
    }
}

#Preview {
    let sampleUser = User(
        id: UUID(),
        name: "John",
        notes: "Great Guy",
        photo: nil,
        latitude: 0,
        longitude: 0
        
    )
    NavigationStack {
        DetailView(user: sampleUser)
    }
}

