//
//  PreviewData.swift
//  RememberMe
//
//  Created by Richard Clarke on 22/05/2025.
//



// Allows Repeat Use of Example Data to display ContentView, GridView & ListViews

import SwiftData
import SwiftUI


#if DEBUG

@MainActor
struct PreviewData {
    static let shared: ModelContainer = {
    
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        let container = try! ModelContainer(for: User.self, configurations: config)
        
        let context = container.mainContext
        
        //Sample Data
        let sampleUsers = [
            User(id: UUID(), name: "Eren Yeager", notes: "A passionate and impulsive warrior driven by freedom, whose ideals evolve into a complex, world-altering mission", photo: UIImage(named: "Eren")?.jpegData(compressionQuality: 1.0), latitude: 40.43, longitude: 116.57),
            User(id: UUID(), name: "Armin Arlet", notes: "A gentle yet brilliant strategist whose empathy and intellect make him the heart of the group.", photo: UIImage(named: "Armin")?.jpegData(compressionQuality: 1.0), latitude: 30.32, longitude: 35.44),
            User(id: UUID(), name: "Mikasa Ackerman", notes: "A fiercely loyal and nearly unstoppable soldier whose strength is only matched by her devotion to Eren.", photo: UIImage(named: "Mikasa")?.jpegData(compressionQuality: 1.0), latitude: 22.95, longitude: 43.21),
            User(id: UUID(), name: "Levi Ackerman", notes: "Humanity’s strongest soldier, cold and efficient in battle, yet driven by a deep sense of duty and loss.", photo: UIImage(named: "Levi")?.jpegData(compressionQuality: 1.0), latitude: 13.16, longitude: 72.54),
            User(id: UUID(), name: "Hange Zoe", notes: "A curious and eccentric genius obsessed with Titans, whose scientific zeal is matched by their fierce loyalty.", photo: UIImage(named: "Hange")?.jpegData(compressionQuality: 1.0), latitude: 20.68, longitude: 88.56),
            User(id: UUID(), name: "Annie Leonheart", notes: "A stoic and deadly warrior with a hidden vulnerability, trapped between duty and personal conflict.", photo: UIImage(named: "Annie")?.jpegData(compressionQuality: 1.0), latitude: 41.89, longitude: 12.49)
        ]
        
        for user in sampleUsers {
            context.insert(user)
        }
        
        return container
        }()
    }

#endif
