import Foundation

protocol JSONDecoderProtocol {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

struct DefaultJSONDecoder: JSONDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        try JSONDecoder().decode(T.self, from: data)
    }
}
