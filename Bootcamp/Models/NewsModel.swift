import Foundation

struct NewsResults: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Identifiable, Codable {
    var id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let content: String
    
    var displayAuthor: String {
        author ?? "No author"
    }
    
    var displayDescription: String {
        description ?? "No description"
    }
    
    var displayImageURL: URL? {
        if let imageUrl = urlToImage {
            return URL(string: imageUrl)
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case content
    }
}

struct Source: Codable {
    let id: String?
    let name: String
}
