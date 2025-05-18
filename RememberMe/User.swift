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
    
    init(id: UUID, name: String, notes: String, photo: Data?) {
        self.id = id
        self.name = name
        self.notes = notes
        self.photo = photo
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
