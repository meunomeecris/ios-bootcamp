//  Created by Cris Messias on 26/07/25.

import SwiftUI

struct ArticleCardView: View {
    let article: Article
    
    var body: some View {
        HStack {
            AsyncImage(url: article.displayImageURL) { phase  in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Image(.imageError)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(.imagePlaceholder)
                        .resizable()
                        .scaledToFit()
                }
            }
            
            VStack {
                Text(article.displayAuthor)
                    .lineLimit(1)
                Text(article.displayDescription)
                    .lineLimit(4)
            }
        }
    }
}
