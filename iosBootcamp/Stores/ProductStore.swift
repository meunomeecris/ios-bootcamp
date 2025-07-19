import Foundation

@MainActor
@Observable final class ProductStore {
    private let productClient = ProductClientMock()
    
    var products: [Product] = []
    var isLoading = false
    var errorMessage: String?

    func fecthProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await productClient.getProducts()
        } catch {
            debugPrint(error)
            errorMessage = "Product loading failed \(error.localizedDescription)"
        }
        isLoading = false
    }
}
