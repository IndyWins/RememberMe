//
//  ContentView.swift
//  RememberMe
//
//  Created by Richard Clarke on 16/05/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) private var users: [User]
    
    @State private var showAddContactSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        Text(user.name)
                    }
                }
                .onDelete(perform: deleteUser)
            }
            .navigationTitle("Contacts")
            .navigationDestination(for: User.self) { user in
                DetailView(user: user)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Contact", systemImage: "plus") {
                        showAddContactSheet.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddContactSheet) {
                AddNewContact()
            }
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
    ContentView()
}
