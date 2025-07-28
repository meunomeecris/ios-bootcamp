import Foundation

@MainActor
@Observable
final class ProductStore {
    private let productClient: ProductClient

    init(client: ProductClient) {
        self.productClient = client
    }

    var products: [Product] = []
    var isLoading = false
    var errorMessage: String?

    func fecthProducts() async {
        isLoading = true

        do {
            products = try await productClient.fetchProducts()
        } catch {
            debugPrint(error)
            errorMessage = "Product loading failed \(error.localizedDescription)"
        }

        isLoading = false
    }
}
