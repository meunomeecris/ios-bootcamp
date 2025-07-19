protocol ProductClient {
    func getProducts() async throws -> [Product]
}
