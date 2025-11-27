//
//  FilteredFriendView.swift
//  FriendsFavoriteMovies
//
//  Created by Jacob Asker on 2025-11-27.
//

import SwiftUI
import SwiftData

struct FilteredFriendList: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationSplitView {
            FriendList(nameFilter: searchText)
                    .searchable(text: $searchText)
        } detail: {
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredFriendList()
        .modelContainer(SampleData.shared.modelContainer)
}
