import Foundation

final class ProductClientMock: ProductClient {
    func getProducts() async throws -> [Product] {
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
