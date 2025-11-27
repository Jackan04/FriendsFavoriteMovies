//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Jacob Asker on 2025-11-25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView{
            FilteredFriendList()
                .tabItem {
                    Label("Friends", systemImage: "person.and.person")
                }
           
            FilteredMovieList()
                .tabItem {
                    Label("Movies", systemImage: "film.stack")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
