import Foundation

struct Cat: Identifiable, Codable {
    let id: String
    let tags: [String]
}


extension Cat {
    var imageURL: URL? {
        URL(string: "https://cataas.com/cat/\(id)")
    }
}
