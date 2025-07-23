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


final class PetClientSucess: PetClient {
    func fetchPet() async throws -> [Pet] {
        return [
            Pet(
                name: "Mosquito",
                type: "cat" ,
                image: "https://i.pinimg.com/736x/b2/60/94/b26094970505bcd59c2e5fe8b6f41cf0.jpg",
                age: 1,
                description: "The Wild Cat", isFavorite: true
            ),
        ]
    }
}


final class PetClientFailed: PetClient {
    func fetchPet() async throws -> [Pet] {
        throw URLError(.cannotOpenFile)
    }
}
