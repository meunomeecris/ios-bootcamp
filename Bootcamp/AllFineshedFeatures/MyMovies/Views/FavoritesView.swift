//  Created by Cris Messias on 31/07/25.

import SwiftUI

struct FavoritesView: View {
    let store: MovieStore
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(store.favoriteMovies) { movie in
                    VStack(alignment: .leading) {
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
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                )
            }
        }
        .padding()
    }
}

#Preview {
    FavoritesView(store: MovieStore(client: MovieClientMock()))
}
