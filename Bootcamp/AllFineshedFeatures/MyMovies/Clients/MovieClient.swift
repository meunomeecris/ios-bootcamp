//  Created by Cris Messias on 31/07/25.

import Foundation

protocol MovieClient {
    func fetchPopularMovies() async throws -> MovieResponse 
    func searchMovie(_ movie: String) async throws -> Movie
}
