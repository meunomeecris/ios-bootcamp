import SwiftUI

struct PetBookView: View {
    let store: PetBookStore
    
    var body: some View {
        NavigationStack {
            List(store.pets) { pet in
                NavigationLink {
                    PetBookDetail(pet: pet, action:  {
                        store.toggleFavorite(for: pet)
                    })
                } label: {
                    PetBookCard(
                        name: pet.name,
                        type: pet.type,
                        isFavorite: pet.isFavorite,
                        url: pet.image) 
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("PetBook")
        }
        .onAppear() {
            Task {
                try await store.fetchPet()
            }
        }
    }
}

#Preview {
    PetBookView(store: PetBookStore(petClient: PetClientMock()))
}
