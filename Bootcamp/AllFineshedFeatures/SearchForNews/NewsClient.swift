import Foundation

protocol NewsClient {
    func fetchNews(for search: String) async throws -> NewsResults
}
