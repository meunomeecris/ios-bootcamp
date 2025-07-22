import Foundation

struct Brewery: Identifiable, Codable {
    let id: String
    let name: String
    let address: String
    let city: String
    let stateProvince: String
    let phone: String
    let website: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address = "address_1"
        case city
        case stateProvince = "state_province"
        case phone
        case website = "website_url"
    }
}
