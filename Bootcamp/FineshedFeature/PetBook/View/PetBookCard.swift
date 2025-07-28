import SwiftUI

struct PetBookCard: View {
    let name: String
    let type: String
    let isFavorite: Bool
    let url: String
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } placeholder: {
                ProgressView("Loading Pets...")
            }
            
           HStack {
                Text(name)
               Spacer()
               Text(type.capitalized)
               Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
           .bold()
           .font(.title2)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.yellow)
                .opacity(0.5)
        )
    }
}


#Preview {
    PetBookCard(name: "Mosquito", type: "cat", isFavorite: true, url: "https://i.pinimg.com/736x/b2/60/94/b26094970505bcd59c2e5fe8b6f41cf0.jpg")
}
