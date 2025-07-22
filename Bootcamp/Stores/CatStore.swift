import Foundation

@MainActor
@Observable
final class CatStore {
    private var catClient: CatClient

    init(catClient: CatClient) {
        self.catClient = catClient
    }

    var cats: [Cat] = []
    var isLoading = false
    var errorMessage: String?

    func loadCats() async {
        isLoading = true

        do {
            cats = try await catClient.fechCats()
        } catch {
            errorMessage = "Failed to load cats: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
