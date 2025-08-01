//  Created by Cris Messias on 28/07/25.

import Foundation

final class GetPhotoClientLive: GetPhotoClient {
    private let session: NetworkSession
    private let decoder: JSONDecoderProtocol
    private let endpoint = "https://picsum.photos/v2/list"
    
    init(
        session: NetworkSession = URLSession.shared,
        decoder: JSONDecoderProtocol = DefaultJSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
    
    func getPhoto() async throws -> [PrintPhoto] {
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            return try decoder.decode([PrintPhoto].self, from: data) 
        } catch {
            throw URLError(.cancelled)
        }
    }
}
