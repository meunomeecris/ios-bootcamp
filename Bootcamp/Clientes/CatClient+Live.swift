import Foundation

class CatClientLive: CatClient {
    func fechCats() async throws -> [Cat] {
        guard let url = URL(string: "https://cataas.com/api/cats") else {
            print("Error: cannot create URL")
            throw URLError(.badURL)
        }

        let urlRequest = URLRequest(url: url)

        let (data, _) = try await URLSession.shared.data(for: urlRequest)

        let decoder = JSONDecoder()
        let catData = try decoder.decode([Cat].self, from: data)

        return catData
    }
}


final class CatClientSucess: CatClient {
    func fechCats() async throws -> [Cat] {
        return [Cat(id: "id", tags: ["Grey"])]
    }
}

final class CatClientFailed: CatClient {
    func fechCats() async throws -> [Cat] {
        throw URLError(.badURL)
    }
}
