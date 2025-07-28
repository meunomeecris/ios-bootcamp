//  Created by Cris Messias on 26/07/25.

import Foundation

@MainActor
@Observable 
final class NewsStore {
    private let client: NewsClient
    private var debounceTask: Task<Void, Never>? = nil
    
    init(client: NewsClient) {
        self.client = client
        loadNews()
    }
    
    var allArticles: [Article] = []
    var isLoading: Bool = false
    var messageError: String?
    var searchText: String = "Swift iOS"
    
   func loadNews() {
        isLoading = true
        Task {
            do {
                allArticles = try await client
                    .fetchNews(for: searchText).articles
            } catch {
                messageError = "Impossibel to find articles \(error)"
            }
        }
        isLoading = false
    }
    
    func searchForArticlesDebounced() {
        debounceTask?.cancel()
        debounceTask = Task {
            try? await Task.sleep(nanoseconds: 100_000_000) 
            loadNews()
        }
    }
}
