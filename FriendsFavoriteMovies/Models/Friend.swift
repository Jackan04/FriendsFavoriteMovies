import Foundation
import SwiftData

@Model
class Friend{
    var name: String
    var birthdate: Date
    var favoriteMovie: Movie?
    
    init(name: String, birthdate: Date = .now){
        self.name = name
        self.birthdate = birthdate
    }
    
    static let sampleData = [
        Friend(name: "Elena"),
        Friend(name: "Graham"),
        Friend(name: "Mayuri"),
        Friend(name: "Rich"),
        Friend(name: "Rody"),
    ]
    
}
