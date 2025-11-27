//
//  FriendDetails.swift
//  FriendsFavoriteMovies
//
//  Created by Jacob Asker on 2025-11-26.
//

import SwiftUI
import SwiftData

struct FriendDetails: View {
    @Bindable var friend: Friend
    let isNew: Bool
    @Query(sort: \Movie.title) private var movies: [Movie]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    init(friend: Friend, isNew: Bool = false){
        self.friend = friend
        self.isNew = isNew
    }
    
    var body: some View {
        Form{
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()
            
            DatePicker("Birthdate", selection: $friend.birthdate, displayedComponents: .date)
           
            Picker("Favorite Movie", selection: $friend.favoriteMovie) {
                Text("None").tag(nil as Movie?)
                
                ForEach(movies) { movie in
                    Text(movie.title).tag(movie)
                }
            }
        }
        .navigationTitle(isNew ? "New Friend" : "Friend Details")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar{
            if(isNew){
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        dismiss()
                    }
                    .buttonStyle(.glassProminent)
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        context.delete(friend)
                        dismiss()
                    }
                }
            }
          
        }

    }
}

#Preview {
    NavigationStack {
        FriendDetails(friend: SampleData.shared.friend)
    }
    .modelContainer(SampleData.shared.modelContainer)
}


#Preview("New Friend") {
    NavigationStack {
        FriendDetails(friend: SampleData.shared.friend, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}

