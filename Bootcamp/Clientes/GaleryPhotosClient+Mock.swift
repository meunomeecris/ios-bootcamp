import Foundation

final class GaleryPhotosMock: GaleryPhotosClient {
    func fetchPhotos() async throws -> [Photo] {
        try await Task.sleep(nanoseconds: 1_000_000_000)

        guard let url = Bundle.main.url(forResource: "parisPhotosMock", withExtension: "json"),
        let data = try? Data(contentsOf: url)
        else {
            throw URLError(.fileDoesNotExist)
        }

        return try JSONDecoder().decode([Photo].self, from: data)
    }
}

final class GaleryPhotosSuccess: GaleryPhotosClient {
    func fetchPhotos() async throws -> [Photo] {
        return [
            Photo(
                id: "1",
                title: "meme",
                imageURL: "https://i.etsystatic.com/44616642/r/il/ab6e69/5063453436/il_570xN.5063453436_fu7w.jpg",
                author: "Cat Meme Digital",
                date: "29-03-2018"
            )
        ]
    }
}

final class GaleryPhotosFailed: GaleryPhotosClient {
    func fetchPhotos() async throws -> [Photo] {
        throw URLError(.badURL)
    }
}
