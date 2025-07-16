import Foundation

struct Photo: Identifiable, Codable {
    let id: String
    let title: String
    let imageURL: String
    let author: String
    let date: String

    enum CodingKeys: String, CodingKey {
        case id, title, author, date
        case imageURL = "image_url"
    }
}
