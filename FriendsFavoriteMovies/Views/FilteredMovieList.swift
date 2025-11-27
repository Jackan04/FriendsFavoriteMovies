//
//  FilteredMovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Jacob Asker on 2025-11-26.
//

import SwiftUI
import SwiftData

struct FilteredMovieList: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationSplitView {
                MovieList(titleFilter: searchText)
                    .searchable(text: $searchText)
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredMovieList()
        .modelContainer(SampleData.shared.modelContainer)
}

