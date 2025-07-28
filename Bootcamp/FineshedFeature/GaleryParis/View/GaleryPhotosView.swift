import SwiftUI
import UIComponents
import WaterfallGrid

struct GaleryPhotosView: View {
    @Bindable var store: ParisPhotoStore
    
    var body: some View {
        ScrollView {
            VStack {
                TitleViewComponent(title: "Paris")
                LoadableViewComponent(
                    data: store.allParisPhotos,
                    errorMessage: store.errorMessage,
                    loadingText: "Loading Paris Photos..."
                ) { _ in
                    GridPhotos(store: store)
                }
            }
        }
        .task {
            await store.loadParisPhoto()
        }
    }
}

#Preview {
    GaleryPhotosView(store: ParisPhotoStore(client: ParisPhotoMock()))
}

private struct GridPhotos: View {
    @Bindable var store: ParisPhotoStore
    
    var body: some View {
        WaterfallGrid(store.allParisPhotos) { photo in
            Button {
                store.infosButtonTapped(for: photo)
            } label: {
                CardImageComponent(
                    url: URL(string: photo.imageURL),
                    placeholderText: "Photos not available"
                )
            }
        }
        .gridStyle(columns: 2)
        .padding()
        .sheet(
            item: $store.selectedPhoto) { selected in
                PhotoDetails(
                    title: selected.title,
                    author: selected.author,
                    date: selected.date)
                .presentationDetents([.fraction(0.2)])
            }
    }
}
