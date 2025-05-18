//
//  AddNewUser.swift
//  RememberMe
//
//  Created by Richard Clarke on 18/05/2025.
//

import PhotosUI
import SwiftData
import SwiftUI

struct AddNewContact: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var selectedImage: Image?
    @State private var name = ""
    @State private var notes = ""
    
    
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
                    
                    Section {
                        selectedImage?
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Section("Additional Notes...") {
                        TextField("Notes", text: $notes)
                    }
                    
                    Button("Save Contact") {
                        guard let photoData = selectedImageData else { return }
                        
                        let newUser = User(id: UUID(), name: name, notes: notes, photo: photoData)
                        
                        modelContext.insert(newUser)
                        
                        dismiss()
                        
                    }
                    .disabled(name.isEmpty || selectedImageData == nil)
                    .padding(5)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .clipShape(.capsule)
                    
                }
            }
        }
        .navigationTitle(Text("Add New User"))
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
    AddNewContact()
}
