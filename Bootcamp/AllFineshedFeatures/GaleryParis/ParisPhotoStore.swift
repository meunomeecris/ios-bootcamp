import Foundation

@MainActor
@Observable
final class ParisPhotoStore {
    private let client: ParisPhotoClient

    init(client: ParisPhotoClient) {
        self.client = client
    }

    var allParisPhotos: [ParisPhoto] = []
    var isLoading = false
    var errorMessage: String?
    var selectedPhoto: ParisPhoto?

    func loadParisPhoto() async {
        isLoading = true

        do {
            allParisPhotos = try await client.fetchPhotos()
        } catch {
            errorMessage = "Failed to load photos: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func infosButtonTapped(for photo: ParisPhoto) {
        selectedPhoto = photo
    }

    func didDismiss() {
        selectedPhoto = nil
    }
}
