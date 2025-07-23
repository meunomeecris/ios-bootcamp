protocol GaleryPhotosClient {
    func fetchPhotos() async throws -> [Photo]
}
