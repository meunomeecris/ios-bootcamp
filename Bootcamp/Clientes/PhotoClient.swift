protocol PhotoClient {
    func fetchPhotos() async throws -> [Photo]
}
