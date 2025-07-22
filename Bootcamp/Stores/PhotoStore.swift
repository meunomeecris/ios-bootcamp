import Foundation

@MainActor
@Observable
final class PhotoStore {
    private let photosClient: PhotoClient

    init(photoClient: PhotoClient) {
        self.photosClient = photoClient
    }

    var photos: [Photo] = []
    var isLoading = false
    var errorMessage: String?
    var selectedPhoto: Photo?

    func loadPhotos() async {
        isLoading = true

        do {
            photos = try await photosClient.fetchPhotos()
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
