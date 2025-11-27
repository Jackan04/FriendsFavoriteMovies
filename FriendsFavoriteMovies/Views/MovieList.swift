//
//  MovieList.swift
//  FriendsFavoriteMovies
//
//  Created by Jacob Asker on 2025-11-25.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Query private var movies: [Movie]
    @Environment(\.modelContext) private var context
    @State private var newMovie: Movie?

    // Custom filtered query, used from FilteredMovieList
    init(titleFilter: String = "") {
        let predicate = #Predicate<Movie> { movie in
            titleFilter.isEmpty || movie.title.localizedStandardContains(titleFilter)
        }
        _movies = Query(filter: predicate, sort: \Movie.title)
    }
    
    var body: some View {
        Group {
            if(!movies.isEmpty) {
                List {
                    ForEach(movies){movie in
                        NavigationLink(movie.title){
                            MovieDetails(movie: movie)                }
                    }
                    .onDelete(perform: deleteMovies(indexes:))
                }
            } else{
                ContentUnavailableView("Add Movie", systemImage: "film.stack")
        } 
        }
         
         .navigationTitle("Movies")
         .toolbar {
             ToolbarItem{
                 Button("Add movie", systemImage: "plus", action: addMovie)
             }
             
             ToolbarItem{
                 EditButton()
             }
         }
         .sheet(item: $newMovie) { movie in
             NavigationStack{
                 MovieDetails(movie: movie, isNew: true)
             }
             .interactiveDismissDisabled()
         }
       
    }
    
    private func addMovie(){
        let newMovie = Movie(title: "New Movie", releaseDate: .now)
        context.insert(newMovie)
        self.newMovie = newMovie
    }
    
    private func deleteMovies(indexes: IndexSet){
        for index in indexes{
            context.delete(movies[index])
        }
    }
}

#Preview {
    NavigationStack{
        MovieList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack{
        MovieList(titleFilter: "2")
            .modelContainer(SampleData.shared.modelContainer)        
    }
}


#Preview("Empty state") {
    FilteredMovieList()
}
