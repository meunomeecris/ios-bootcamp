protocol ProductClient {
    func fetchProducts() async throws -> [Product]
}
