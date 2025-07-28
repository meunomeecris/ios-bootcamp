import Foundation

final class ProductClientMock: ProductClient {
    func fetchProducts() async throws -> [Product] {
        try await Task.sleep(for: .seconds(3))

        guard let url = Bundle.main.url(forResource: "productsMock", withExtension: "json") else {
            throw URLError(.badURL)
        }
        guard let data = try? Data(contentsOf: url) else {
            throw URLError(.fileDoesNotExist)
        }

        return try JSONDecoder().decode([Product].self, from: data)
    }
}


final class ProductClientSucess: ProductClient {
    func fetchProducts() async throws -> [Product] {
        return [Product(name: "Sun glasses", price: 24.99)]
    }
}

final class ProductClientFailed: ProductClient {
    func fetchProducts() async throws -> [Product] {
        throw URLError(.badURL)
    }
}
