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
    
    @AppStorage("showingGrid") private var showingGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    ListLayout()
                } else {
                    GridLayout()
                }
            }
            .toolbar {
                                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                    showingGrid.toggle()
                    } label: {
                        if showingGrid {
                            Label ("Show as grid", systemImage: "square.grid.2x2")
                        } else {
                            Label ("Show as list", systemImage: "list.dash")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Contact", systemImage: "plus") {
                        showAddContactSheet.toggle()
                    }
                }
                
                if showingGrid {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
            }
            .navigationTitle("Contacts")
            .navigationDestination(for: User.self) { user in
                DetailView(user: user)
            }
            .sheet(isPresented: $showAddContactSheet) {
                NewContactView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .modelContainer(PreviewData.shared)
    }
}
