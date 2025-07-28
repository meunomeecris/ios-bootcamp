//  Created by Cris Messias on 28/07/25.

import Foundation

final class GetPhotoClientLive: GetPhotoClient {
    func getPhoto() async throws -> [PrintPhoto] {
        let endpoint = "https://picsum.photos/v2/list"
        guard let url = URL(string: endpoint) else {
            print("Not a valid URL")
            throw URLError(.badURL)
        }
    
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            print("HTTPURLResponse error")
            throw URLError(.badServerResponse)
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            print("HTTP status code error \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let photoResult: [PrintPhoto]
        do {
            photoResult = try JSONDecoder()
                .decode([PrintPhoto].self, from: data)
        } catch {
            print("JSONDecoder error \(error)")
            throw URLError(.cancelled)
        }
        
        return photoResult
    }
}
