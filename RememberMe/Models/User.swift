//
//  NewContact.swift
//  RememberMe
//
//  Created by Richard Clarke on 18/05/2025.
//

import PhotosUI
import Foundation
import SwiftData
import SwiftUI

@Model
class User {
    
    var id: UUID
    var name: String
    var notes: String
    
    @Attribute(.externalStorage) var photo: Data?
    
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(id: UUID, name: String, notes: String, photo: Data?, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.notes = notes
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude

    }
}


extension User {
    var image: Image? {
        guard let photo = self.photo,
              let uiImage = UIImage(data:photo) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}
