//  Created by Cris Messias on 31/07/25.

import Foundation

final class MovieClientLive: MovieClient {
    func fetchPopularMovies() async throws -> MovieResponse {
        let endpoint = "https://api.themoviedb.org/3/movie/popular"
        let apiKey = getMovieAPIKey()
        
        var components = URLComponents(string: endpoint)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"), 
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            break
        case 400..<500:
            throw URLError(.badServerResponse)
        case 500..<600:
            throw URLError(.badServerResponse)
        default:
            throw URLError(.unknown)
        }
        
        do {
            let allMovies: MovieResponse
            allMovies = try JSONDecoder().decode(MovieResponse.self, from: data)
            return allMovies
        } catch {
            print("JSONDecoder failed \(error)")
            throw URLError(.badServerResponse)
        }
    }

    func searchMovie(_ movie: String) async throws -> Movie {
        return Movie(
            id: 27205,
            title: "Inception",
            overview: """
        Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: "inception", the implantation of another person's idea into a target's subconscious.
        """,
            posterPath: "/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg",
            isFavorite: false
        )
    }
}

