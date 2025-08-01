//  Created by Cris Messias on 31/07/25.
//

import Foundation

final class MovieClientMock: MovieClient {
    func fetchPopularMovies() async throws -> MovieResponse {
        try await Task.sleep(for:  .seconds(2))
        
        let mockMovies: [Movie] = [
            Movie(
                id: 27205,
                title: "Inception",
                overview: """
        Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: "inception", the implantation of another person's idea into a target's subconscious.
        """,
                posterPath: "/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg",
                isFavorite: false
            ),
            Movie(
                id: 613092,
                title: "The Crack: Inception",
                overview: """
        Madrid, Spain, 1975; shortly after the end of the Franco dictatorship. Six months after the mysterious death of his lover, a prestigious tailor, a married woman visits the office of the young Germán Areta, a former police officer turned private detective, to request his professional services.
        """,
                posterPath: "/kzgPu2CMxBr4YZZxC1Off4cUfR9.jpg",
                isFavorite: true
            )
        ]
        return MovieResponse(results: mockMovies)
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
