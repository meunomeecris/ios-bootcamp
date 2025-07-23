import SwiftUI
import UIComponents
import WaterfallGrid

struct CatPhotoView: View {
    let store: CatPhotoStore
    
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
                    WaterfallGrid(store.cats) { cat in
                        CardImage(
                            url: cat.imageURL,
                            placeholderText: "Photos not available"
                        )
                    }
                    .gridStyle(columns: 2)
                    .padding()
                }
            }
        }
        .task {
            await store.loadCats()
        }
    }
}

#Preview {
    CatPhotoView(store: CatPhotoStore(catClient: CatPhotoLive()))
}
