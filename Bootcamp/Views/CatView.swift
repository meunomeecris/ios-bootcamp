import SwiftUI
import UIComponents

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
                            CardImage(url: cat.imageURL, placeholderText: "Photos not available")
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
