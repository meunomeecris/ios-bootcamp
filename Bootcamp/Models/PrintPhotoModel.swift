//  Created by Cris Messias on 28/07/25.

import Foundation


struct PrintPhoto: Identifiable, Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadURL: String
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

struct OrderPrintPhoto: Identifiable, Codable {
    let id: Int
    let total: Int
    let photos: [PrintPhoto]
    let date: Date
}
