//
//  DetailView.swift
//  RememberMe
//
//  Created by Richard Clarke on 18/05/2025.
//

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
        photo: nil
    )
    NavigationStack {
        DetailView(user: sampleUser)
    }
}

