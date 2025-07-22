import SwiftUI

struct PetBookDetail: View {
    var pet: Pet
    var action: () -> Void
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                VStack {
                    AsyncImage(url: URL(string: pet.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } placeholder: {
                        ProgressView("Loading Pets...")
                    }
                }
                Button() {
                   action()
                } label: {
                    Image(systemName: pet.isFavorite ? "heart.fill" : "heart")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                }
                .padding(30)
            }
            
            List {
                Section("Infos") {
                    Label(pet.name, systemImage: "cat")
                    Label(String(pet.type), systemImage: "link")
                    Label(String(pet.age), systemImage: "number")
                    Label(pet.description, systemImage: "quote.opening")
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .padding(16)
    }
}

#Preview {
    PetBookDetail(pet: Pet(name: "Mosquito", type: "cat" , image: "https://i.pinimg.com/736x/b2/60/94/b26094970505bcd59c2e5fe8b6f41cf0.jpg", age: 1, description: "The Wild Cat", isFavorite: true), action: {})
}
