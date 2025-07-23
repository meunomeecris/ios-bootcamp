import Foundation

@MainActor
@Observable
final class GaleryPhotosStore {
    private let galeryPhotosClient: GaleryPhotosClient

    init(galeryPhotosClient: GaleryPhotosClient) {
        self.galeryPhotosClient = galeryPhotosClient
    }

    var photos: [Photo] = []
    var isLoading = false
    var errorMessage: String?
    var selectedPhoto: Photo?

    func loadPhotos() async {
        isLoading = true

        do {
            photos = try await galeryPhotosClient.fetchPhotos()
        } catch {
            errorMessage = "Failed to load photos: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func infosButtonTapped(for photo: Photo) {
        selectedPhoto = photo
    }

    func didDismiss() {
        selectedPhoto = nil
    }
}
