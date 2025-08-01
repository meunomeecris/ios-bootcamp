//  Created by Cris Messias on 31/07/25.

import SwiftUI

struct MovieListView: View {
    @Bindable var store: MovieStore
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach($store.popularMovies, id: \.id) { movie in
                    if let indice = store.popularMovies.firstIndex(where: { $0.id == movie.id
                        }) {
                        VStack(alignment: .leading) {
                            MovieNavigationToDetails(movie: $store.popularMovies[indice])
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.2))
                        )
                    }
                }
            }
            .padding()
        }
    }
}


struct MovieNavigationToDetails: View {
    @Binding var movie: Movie
    
    var body: some View {
        NavigationLink {
            MovieDetailsView(movie: $movie)
        } label: {
            VStack {
                MovieLoadImage(movie: movie) 
                HStack {
                    Text(movie.title)
                        .foregroundStyle(.black)
                        .font(.subheadline)
                        .bold()
                    Spacer()
                    Image(systemName: movie.isFavorite ? "star.fill" : "")
                        .font(.title2)
                        .foregroundStyle(.yellow)
                }
            }
        }
    }
}
