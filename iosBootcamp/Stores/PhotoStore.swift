import Foundation

@MainActor
@Observable final class PhotoStore {
    private var photosClient = PhotoClientMock()
    
    var photos: [Photo] = []
    var isLoading = false
    var errorMessage: String?
    
    var selectedPhoto: Photo? = nil
    
    func loadPhotos() async {
        isLoading = true
        errorMessage = nil
        
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
