import Foundation

final class HandleAPIError {
    func fetchData() async throws {
        guard let url = URL(string: "https://www.mocky.io") else {
            throw APIError.invalidURL
        }
        let(_, response) = try await URLSession.shared.data(from: url)
        let http = response as! HTTPURLResponse
        guard (200..<300).contains(http.statusCode) else {
            throw APIError.statusCode(http.statusCode)
        }
    }
}

