import Foundation

class PhotoClientMock: Decodable {

    func fetchPhotos() async throws -> [Photo] {
        try await Task.sleep(nanoseconds: 1_000_000_000)

        guard let url = Bundle.main.url(forResource: "photosData", withExtension: "json"),
              let data = try? Data(contentsOf: url)
        else {
            throw URLError(.fileDoesNotExist)
        }

        return try JSONDecoder().decode([Photo].self, from: data)
    }
    
}
