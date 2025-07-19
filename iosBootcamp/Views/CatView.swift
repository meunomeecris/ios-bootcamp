import SwiftUI

struct CatView: View {
    let store: CatStore
    let columns = [GridItem(.adaptive(minimum: 100)), GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        ScrollView {
            VStack {
                if store.isLoading {
                    ProgressView()
                    Text("Loading Cats...")
                        .font(.callout)
                        .bold()
                } else if let error = store.errorMessage {
                    Text(error)
                        .font(.callout)
                        .bold()
                } else {
                    LazyVGrid(columns: columns) {
                        ForEach(store.cats) { cat in
                            CatCard(url: cat.imageURL)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .task {
            await store.loadCats()
        }
    }
}

#Preview {
    CatView(store: CatStore(catClient: CatClientLive()))
}


struct CatCard: View {
    let url: URL?
    
    var body: some View {
        VStack {
            if let url = url {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                    Text("Photos not available")
                        .font(.callout)
                        .bold()
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}
