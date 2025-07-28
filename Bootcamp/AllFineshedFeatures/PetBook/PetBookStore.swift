import Foundation

@MainActor
@Observable
final class PetBookStore {
    private let petClient: PetClient
    
    init(client: PetClient) {
        self.petClient = client
    }
    
    var pets: [Pet] = []
    var errorMessage: String?
    
    func fetchPet() async throws {
        do {
            pets = try await petClient.fetchPet()
        } catch {
            errorMessage = "Fail to load Pets \(error.localizedDescription)"
        }
    }
    
    func toggleFavorite(for pet: Pet) {
        if let index = pets.firstIndex(of: pet) {
            pets[index].isFavorite.toggle()
        }
    }
}
