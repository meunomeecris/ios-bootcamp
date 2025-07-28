//  Created by Cris Messias on 26/07/25.

import Foundation

final class NewsClientLive: NewsClient {
    
    func fetchNews(for search: String) async throws -> NewsResults {
        let apiKey = getAPIKey() 
        let endpoint = "https://newsapi.org/v2/everything"
        let date = "2025-07-20"
        let filter = "popularity"
        
        var components = URLComponents(string: endpoint)
        components?.queryItems = [
            URLQueryItem(name: "q", value: search),
            URLQueryItem(name: "from", value: date),
            URLQueryItem(name: "sortBy", value: filter),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let results =  try JSONDecoder().decode(NewsResults.self, from: data)
        
        return results
    }
}
