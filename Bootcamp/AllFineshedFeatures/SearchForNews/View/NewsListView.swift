//  Created by Cris Messias on 26/07/25.

import SwiftUI

struct NewsListView: View {
    @Bindable var store: NewsStore
    
    var body: some View {
        NavigationStack {
            List {
                Section("All Articles") {
                    ForEach(store.allArticles) { article in
                        NavigationLink {
                            ArticleDetails(article: article)
                        } label: {
                            ArticleCardView(article: article)
                        }
                    }
                }
            }
            .searchable(text: $store.searchText, prompt: "Search articles about...")
            .onChange(of: store.searchText) {
                store.searchForArticlesDebounced()
            }
        }
    }
}

#Preview {
    NewsListView(store: NewsStore(client: NewsClientLive()))
}
