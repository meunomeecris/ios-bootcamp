protocol ParisPhotoClient {
    func fetchPhotos() async throws -> [ParisPhoto]
}
