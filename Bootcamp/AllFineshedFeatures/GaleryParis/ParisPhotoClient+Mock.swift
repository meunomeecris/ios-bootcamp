import Foundation

final class ParisPhotoMock: ParisPhotoClient {
    func fetchPhotos() async throws -> [ParisPhoto] {
        try await Task.sleep(nanoseconds: 1_000_000_000)

        guard let url = Bundle.main.url(forResource: "parisPhotosMock", withExtension: "json"),
        let data = try? Data(contentsOf: url)
        else {
            throw URLError(.fileDoesNotExist)
        }

        return try JSONDecoder().decode([ParisPhoto].self, from: data)
    }
}

final class ParisPhotoSuccess: ParisPhotoClient {
    func fetchPhotos() async throws -> [ParisPhoto] {
        return [
            ParisPhoto(
                id: "1",
                title: "meme",
                imageURL: "https://i.etsystatic.com/44616642/r/il/ab6e69/5063453436/il_570xN.5063453436_fu7w.jpg",
                author: "Cat Meme Digital",
                date: "29-03-2018"
            )
        ]
    }
}

final class ParisPhotoFailed: ParisPhotoClient {
    func fetchPhotos() async throws -> [ParisPhoto] {
        throw URLError(.badURL)
    }
}
