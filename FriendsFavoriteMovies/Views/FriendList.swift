//
//  FriendList.swift
//  FriendsFavoriteMovies
//
//  Created by Jacob Asker on 2025-11-25.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Query(sort: \Friend.name) var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newFriend: Friend?
    
    var body: some View {
        NavigationSplitView {
          Group {
                if !friends.isEmpty {
                    List {
                        ForEach(friends) { friend in
                            NavigationLink(friend.name) {
                                FriendDetails(friend: friend)
                            }
                        }
                        .onDelete(perform: deleteFriends(indexes:))
                    }
                } else{
                    ContentUnavailableView("Add Friends", systemImage: "person.2")
                    
                }
            }
            .navigationTitle("Friends")
            .toolbar {
                ToolbarItem{
                    Button("Add friend", systemImage: "plus", action: addFriend)
                }
                
                ToolbarItem{
                    EditButton()
                }
            }
            .sheet(item: $newFriend) { friend in
                 NavigationStack {
                     FriendDetails(friend: friend, isNew: true)
                 }
                 .interactiveDismissDisabled()
            }
           
            
        } detail: {
             Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }

    }
    
    private func addFriend(){
        let newFriend = Friend(name: "New Friend", birthdate: .now)
        context.insert(newFriend)
        self.newFriend = newFriend
    }
    
    private func deleteFriends(indexes: IndexSet){
        for index in indexes{
            context.delete(friends[index])
        }
    }
    
        }

#Preview {
    FriendList()
        .modelContainer(SampleData.shared.modelContainer)
        
}

#Preview("Empty state") {
    FriendList()
}
