//
//  MovieDetails.swift
//  FriendsFavoriteMovies
//
//  Created by Jacob Asker on 2025-11-26.
//

import SwiftUI
import SwiftData

struct MovieDetails: View {
    @Bindable var movie: Movie
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    init(movie: Movie, isNew: Bool = false){
        self.movie = movie
        self.isNew = isNew
    }
    
    var sortedFriends:[Friend]{
        movie.favoritedBy.sorted {first, second in
            return first.name < second.name
        }
    }
    
    var body: some View {
        Form{
            TextField("Movie title", text: $movie.title)
                .autocorrectionDisabled()
            DatePicker("Release date", selection: $movie.releaseDate, displayedComponents: .date)
            
            if(!movie.favoritedBy.isEmpty){
                Section("Favorited by"){
                    ForEach(sortedFriends){friend in
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationTitle(isNew ? "New Movie" : "Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            if(isNew){
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save"){
                        dismiss()
                    }
                    .buttonStyle(.glassProminent)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        context.delete(movie)
                        dismiss()
                    }
                }
            }
           
        }

  

    }
}

#Preview {
    NavigationStack{
        MovieDetails(movie: SampleData.shared.movie)        
    }
}
