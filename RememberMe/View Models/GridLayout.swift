//
//  GridLayoutView.swift
//  RememberMe
//
//  Created by Richard Clarke on 22/05/2025.
//

import SwiftData
import SwiftUI

struct GridLayout: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) private var users: [User]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        VStack {
                            
                            if let userImage = user.image {
                                userImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:150, height:150)
                                    .padding(10)
                            }
                            
                            Text(user.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground))
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    NavigationStack {
        GridLayout()
            .modelContainer(PreviewData.shared)
    }
}
