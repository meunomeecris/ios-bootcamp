import Foundation

struct Product: Identifiable, Codable {
    var id = UUID()
    let name: String
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case name, price
    }
}
