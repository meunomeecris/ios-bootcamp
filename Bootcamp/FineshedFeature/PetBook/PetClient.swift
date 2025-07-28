protocol PetClient {
    func fetchPet() async throws -> [Pet]
}
