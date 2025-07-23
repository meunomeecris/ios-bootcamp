import SwiftUI
import UIComponents
import WaterfallGrid

struct CatPhotoView: View {
    @Bindable var store: CatPhotoStore
    
    var body: some View {
        ScrollView {
            Text("Cat's Photos")
                .font(.largeTitle)
                .bold()
            
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
                        .onTapGesture {
                            store.selectedCat = cat
                        }
                    }
                    .gridStyle(columns: 2)
                    .padding()
                }
            }
            .fullScreenCover(item: $store.selectedCat) { cat in
                FullScreenPhotoView(photo: cat) {
                    store.selectedCat = nil
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


private struct FullScreenPhotoView: View {
    var photo: CatPhoto
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()
            
            AsyncImage(url: photo.imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } placeholder: {
                ProgressView()
            }
            
            Button(action: onDismiss) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}
