import Foundation

struct Pet: Identifiable, Codable, Hashable {
    var id = UUID()
    let name: String
    let type: String
    let image: String
    let age: Int
    let description: String
    var isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, type, image, age, description, isFavorite
    }
}



