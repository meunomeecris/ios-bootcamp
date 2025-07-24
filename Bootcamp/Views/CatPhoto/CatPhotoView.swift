import SwiftUI
import WaterfallGrid
import UIComponents

struct CatPhotoView: View {
    @Bindable var store: CatPhotoStore
    
    var body: some View {
        ScrollView {
            VStack {
                TitleViewComponent(title: "Cat Photos")
                LoadableViewComponent(
                    data: store.cats,
                    errorMessage: store.errorMessage,
                    loadingText: "Photos not available"
                ) {_ in
                    WaterfallGrid(store.cats) { cat in
                        CardImageComponent(
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
                FullScreenPhotoView(
                    photo: cat,
                    text: "Loading Photo..."
                ) {
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

