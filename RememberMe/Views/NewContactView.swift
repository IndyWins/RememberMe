//
//  AddNewUser.swift
//  RememberMe
//
//  Created by Richard Clarke on 18/05/2025.
//

import MapKit
import PhotosUI
import SwiftData
import SwiftUI

struct NewContactView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var selectedImage: Image?
    
    @State private var name = ""
    @State private var notes = ""
    
    @State private var latitude = 0.00
    @State private var longitude = 0.00
    
    @State private var showPin = false
    
    @State private var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 54, longitude: -2), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)))
    
    var pinnedCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        VStack {
            Form {
                
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    Label("Choose your picture...", systemImage: "photo")
                }
                
                if selectedImage != nil {
                    
                    Section("Enter Contact Name") {
                        TextField("Name", text: $name)
                    }
                    
                    Section("Contact Photo") {
                        selectedImage?
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Section("Where we met...") {
                        MapReader { proxy in
                            Map(position: $cameraPosition, interactionModes: [ ] ) {
                                Annotation(name, coordinate: pinnedCoordinate) {
                                    Image(systemName: "pin.fill")
                                        .resizable()
                                        .foregroundStyle(.red)
                                }
                            }
                            .frame(height:150)
                        }
                        
                        Button("Add Location") {
                            if let location = locationFetcher.lastKnownLocation {
                                latitude = location.latitude
                                longitude = location.longitude
                                showPin = true
                                
                                cameraPosition = .region(
                                    MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)))
                                
                                print("Latitude:\(location.latitude)")
                                print(("Longitude:\(location.longitude)"))
                            } else {
                                print("Location Unknown")
                            }
                        }
                        .buttonStyle(.automatic)
                        .padding(.horizontal)
                    }
                    
                    Section("Additional Notes...") {
                        TextField("Notes", text: $notes)
                    }
                }
            }
            
            
            Button("Save Contact") {
                guard let photoData = selectedImageData else { return }
                
                let newUser = User(id: UUID(), name: name, notes: notes, photo: photoData, latitude: latitude, longitude: longitude)
                
                modelContext.insert(newUser)
                
                do {
                    try modelContext.save()
                    print("User Saved Successfully")
                    dismiss()
                } catch {
                    print("Failed to save: \(error.localizedDescription)")
                }
            }
            .disabled(name.isEmpty || selectedImageData == nil)
            .buttonStyle(.borderedProminent)
            
        }
        .navigationTitle(Text("Add New User"))
        .onAppear { locationFetcher.start() }
        .onChange(of: pickerItem) {
            Task {
                if let data = try? await pickerItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImageData = data
                    selectedImage = Image(uiImage: uiImage)
                }
            }
        }
    }
}

#Preview {
    NewContactView()
}
