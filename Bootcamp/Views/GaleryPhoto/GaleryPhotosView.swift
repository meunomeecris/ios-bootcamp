import SwiftUI
import UIComponents
import WaterfallGrid

struct GaleryPhotosView: View {
    @Bindable var store: GaleryPhotosStore
    
    var body: some View {
        ScrollView {
            TitleViewComponent(title: "Paris")
            VStack {
                if store.isLoading {
                    ProgressViewComponent(text: "Loading Paris Photos...")
                } else if let error = store.errorMessage {
                    MessageErrorComponent(error: error)
                } else {
                    GridPhotos(store: store)
                }
            }
        }
        .task {
            await store.loadPhotos()
        }
    }
}

#Preview {
    GaleryPhotosView(store: GaleryPhotosStore(galeryPhotosClient: GaleryPhotosMock()))
}

private struct GridPhotos: View {
    @Bindable var store: GaleryPhotosStore
    
    var body: some View {
        WaterfallGrid(store.photos) { photo in
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
