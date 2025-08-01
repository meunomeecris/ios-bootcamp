//
//  MyMovies.swift
//  MyMovies
//
//  Created by Cris Messias on 31/07/25.
//

import SwiftUI

struct MyMovies: View {
    @Bindable var store: MovieStore
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    Tab("My Movies", systemImage: "movieclapper") {
                        MoviesView(store: store)
                    }
                    Tab("Favorites", systemImage: "star") { 
                        FavoritesView(store: store)
                    }
                }
            }
            .navigationTitle("My Movies")
            .searchable(text: $store.searchMovieInput)
        }
        .task {
            await store.fetchPopularMovies()
        }
    }
}


#Preview {
    MyMovies(store: MovieStore(client: MovieClientMock()))
}
