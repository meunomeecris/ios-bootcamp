//  Created by Cris Messias on 31/07/25.
//

import SwiftUI

struct MovieDetailsView: View {
    @Binding var movie: Movie
    
    var body: some View {
        VStack {
            Text(movie.title)
                .font(.title2)
            Text(movie.overview)
                .font(.body)
            
            Button { 
                movie.isFavorite.toggle()
            } label: { 
                Image(systemName: movie.isFavorite ? "star.fill" :"")
                    .font(.title2)
                    .foregroundStyle(.yellow)
                Text(movie.isFavorite ? "Remove from favorites" : "Add to favorites") 
            }
        }
        .padding()
        Spacer()
    }
}
