//  Created by Cris Messias on 31/07/25.

import Foundation

@Observable
final class MovieStore {
    private let store: MovieClient
    
    init(client: MovieClient) {
        self.store = client
    }
    
    var popularMovies: [Movie] = []
    var searchMovieResults: Movie?
    var isLoading = false
    var messageError: String?
    var searchMovieInput: String = ""
    var favoriteMovies: [Movie]  {
        return popularMovies.filter { $0.isFavorite == true }
    }
    
    @MainActor
    func fetchPopularMovies() async {
        isLoading = true
        do {
            popularMovies = try await store.fetchPopularMovies().results
        } catch {
            messageError = "Impossible de charger les films. \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    @MainActor
    func searchMovie() async {
        isLoading = true
        do {
            searchMovieResults = try await store.searchMovie(searchMovieInput)
        } catch {
            messageError = "Désolé, il n'y a aucun film correspondant à votre recherche. \(error.localizedDescription)"
        }
    }
    
}
