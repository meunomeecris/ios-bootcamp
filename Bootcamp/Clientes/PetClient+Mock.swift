import Foundation

final class PetClientMock: PetClient {
    func fetchPet() async throws -> [Pet] {
        //URL
        guard let url = Bundle.main.url(forResource: "animalsMock", withExtension: "json") else {
            print("Error: JSON file not found")
            throw URLError(.badURL)
        }
        
        //Transformer en Type Data
        guard let data = try? Data(contentsOf: url) else {
            print("Error: Cannot convert JSON file to Data")
            throw URLError(.cannotCreateFile)
        }
        
        //Transforme la data en liste du type Animal
        return try JSONDecoder().decode([Pet].self, from: data)
    }
}
