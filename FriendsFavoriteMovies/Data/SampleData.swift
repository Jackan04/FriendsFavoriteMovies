//
//  SampleData.swift
//  FriendsFavoriteMovies
//
//  Created by Jacob Asker on 2025-11-25.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
         return modelContainer.mainContext
     }
    
    var friend: Friend{
        return Friend.sampleData.first!
    }
    
    var movie: Movie{
        return Movie.sampleData.first!
    }
    
    // Custom initializer for managing sample data
    private init() {
        let schema = Schema([
            Friend.self,
            Movie.self,
            ]
        )
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            
            try context.save()
            
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData(){
        for friend in Friend.sampleData {
            context.insert(friend)
        }
        
        for movie in Movie.sampleData {
            context.insert(movie)
        }
        
        // Add favorite movies
        Friend.sampleData[0].favoriteMovie = Movie.sampleData[1]
        Friend.sampleData[2].favoriteMovie = Movie.sampleData[0]
        Friend.sampleData[3].favoriteMovie = Movie.sampleData[4]
        Friend.sampleData[4].favoriteMovie = Movie.sampleData[0]
    }
    
  
    
}
