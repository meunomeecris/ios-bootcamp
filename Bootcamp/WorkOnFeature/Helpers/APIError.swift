import Foundation

enum APIError: Error {
    case invalidURL
    case requestFail
    case invalidResponse
    case statusCode(Int)
    case decodingError
    
    var message: String {
        switch self {
        case .invalidURL, .requestFail, .invalidResponse, .decodingError:
            return "We are handling some internal issues. Please try again!"
        case .statusCode(let code):
            return "Error code: \(code). Something went wrong. Please try again!"
        }
    }
}
