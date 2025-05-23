//
//  PreviewData.swift
//  RememberMe
//
//  Created by Richard Clarke on 22/05/2025.
//



// Allows Repeat Use of Example Data to display ContentView, GridView & ListViews

import SwiftData
import SwiftUI

@MainActor
struct PreviewData {
    static let shared: ModelContainer = {
    
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        let container = try! ModelContainer(for: User.self, configurations: config)
        
        let context = container.mainContext
        
        //Sample Data
        let sampleUsers = [
            User(id: UUID(), name: "Eren", notes: "", photo: UIImage(named: "Eren")?.jpegData(compressionQuality: 1.0), latitude: 0.0, longitude: 0.0),
            User(id: UUID(), name: "Armin", notes: "", photo: UIImage(named: "Armin")?.jpegData(compressionQuality: 1.0), latitude: 0.0, longitude: 0.0),
            User(id: UUID(), name: "Mikasa", notes: "", photo: UIImage(named: "Mikasa")?.jpegData(compressionQuality: 1.0), latitude: 0.0, longitude: 0.0),
            User(id: UUID(), name: "Levi", notes: "", photo: UIImage(named: "Levi")?.jpegData(compressionQuality: 1.0), latitude: 0.0, longitude: 0.0),
            User(id: UUID(), name: "Hange", notes: "", photo: UIImage(named: "Hange")?.jpegData(compressionQuality: 1.0), latitude: 0.0, longitude: 0.0),
            User(id: UUID(), name: "Annie", notes: "", photo: UIImage(named: "Annie")?.jpegData(compressionQuality: 1.0), latitude: 0.0, longitude: 0.0)
        ]
        
        for user in sampleUsers {
            context.insert(user)
        }
        
        return container
        }()
    }
