//
//  ListLayout.swift
//  RememberMe
//
//  Created by Richard Clarke on 22/05/2025.
//

import SwiftData
import SwiftUI

struct ListLayout: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) private var users: [User]
    
    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink(value: user) {
                    HStack {
                            if let userImage = user.image {
                                userImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:70, height:70)
                                    .padding()
                            }
                            
                            Text(user.name)
                                .font(.headline)
                    }
                }
            }
            .onDelete(perform: deleteUser)
            .listStyle(.plain)
        }
    }
    func deleteUser (at offsets: IndexSet) {
        for offset in offsets {
            let user = users[offset]
            modelContext.delete(user)
        }
    }
}

#Preview {
    NavigationStack {
        ListLayout()
            .modelContainer(PreviewData.shared)
    }
}
