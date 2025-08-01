//  Created by Cris Messias on 28/07/25.

import Foundation

final class PostPrintClientLive: PostPrintClient {
    private let session: NetworkSession
    private let encoder: JSONEncoder
    private let endpoint = "https://webhook.site/97dde2b5-c531-4eee-ada1-b2f685743f0f"
    
    init(
        session: NetworkSession = URLSession.shared,
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.session = session
        self.encoder = encoder
    }
    
    func sendOrder(for order: [OrderPrintPhoto]) async throws {
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(order)
        
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
