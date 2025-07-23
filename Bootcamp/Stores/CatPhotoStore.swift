import Foundation

@MainActor
@Observable
final class CatPhotoStore {
    private var catClient: CatPhotoClient

    init(catClient: CatPhotoClient) {
        self.catClient = catClient
    }

    var cats: [CatPhoto] = []
    var isLoading = false
    var errorMessage: String?
    var selectedCat: CatPhoto? = nil

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
