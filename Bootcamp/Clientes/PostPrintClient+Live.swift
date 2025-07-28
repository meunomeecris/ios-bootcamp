//  Created by Cris Messias on 28/07/25.

import Foundation

final class PostPrintClientLive: PostPrintClient {
    func sendOrder(for order: [OrderPrintPhoto]) async throws {
        let endpoint = "https://webhook.site/4fbc4fef-aa22-42f5-a489-9de17bbcd891"
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(order)
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            print("Response: \(response)")
        } catch {
            print("Post request error: \(error.localizedDescription)")
        }
    }
}
