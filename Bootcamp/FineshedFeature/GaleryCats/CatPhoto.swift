import Foundation

struct CatPhoto: Identifiable, Codable {
    let id: String
    let tags: [String]
}


extension CatPhoto {
    var imageURL: URL? {
        URL(string: "https://cataas.com/cat/\(id)")
    }
}
