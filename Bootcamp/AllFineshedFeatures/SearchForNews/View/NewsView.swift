//  Created by Cris Messias on 26/07/25.

import SwiftUI

struct NewsView: View {
    let store: NewsStore
    
    var body: some View {
        NavigationStack {
            VStack {
                if store.isLoading {
                    ProgressView("Loading News...")
                } else if let error = store.messageError {
                    Text(error)
                } else {
                    if store.allArticles.isEmpty {
                        Text("No News Found")
                    } else  {
                        NewsListView(store: store)
                    }
                }
            }
            .navigationTitle("News")
        }
    }
}

#Preview {
    NewsView(store: NewsStore(client: NewsClientLive()))
}
