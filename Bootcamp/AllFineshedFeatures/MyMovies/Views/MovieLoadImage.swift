//  Created by Cris Messias on 31/07/25.

import SwiftUI

struct MovieLoadImage: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            AsyncImage(url: movie.posterURL) { phase in 
                if let image = phase.image {
                    image 
                        .resizable()
                        .scaledToFill()
                } else if (phase.error != nil) {
                    Image(.imageError)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                } else {
                    Image(.imagePlaceholder)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                }
            }
        }
    }
}

#Preview {
    MovieLoadImage(movie: Movie.preview)
}
