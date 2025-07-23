import Foundation

class CatPhotoLive: CatPhotoClient {
    func fechCats() async throws -> [CatPhoto] {
        guard let url = URL(string: "https://cataas.com/api/cats") else {
            print("Error: cannot create URL")
            throw URLError(.badURL)
        }

        let urlRequest = URLRequest(url: url)

        let (data, _) = try await URLSession.shared.data(for: urlRequest)

        let decoder = JSONDecoder()
        let catData = try decoder.decode([CatPhoto].self, from: data)

        return catData
    }
}


final class CatPhotoSucess: CatPhotoClient {
    func fechCats() async throws -> [CatPhoto] {
        return [CatPhoto(id: "id", tags: ["Grey"])]
    }
}

final class CatPhotoFailed: CatPhotoClient {
    func fechCats() async throws -> [CatPhoto] {
        throw URLError(.badURL)
    }
}
