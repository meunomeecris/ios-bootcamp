import SwiftUI
import UIComponents

struct PhotoView: View {
    let store: PhotoStore
    var body: some View {
        @Bindable var bStore = store
        VStack {
            if store.isLoading {
                ProgressView()
            } else if let error = store.errorMessage {
                Text(error)
            } else {
                GaleryPhoto(store: store, bStore: bStore)
            }
        }
        .task {
            await store.loadPhotos()
        }
    }
}

#Preview {
    PhotoView(store: PhotoStore(photoClient: PhotoClientMock()))
}

private struct GaleryPhoto: View {
    let store: PhotoStore
    let columns = [GridItem(.adaptive(minimum: 100)), GridItem(.adaptive(minimum: 100))]
    @Bindable var bStore: PhotoStore
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(store.photos) { photo in
                PhotoCard(
                    imageURL: photo.imageURL) {
                    store.infosButtonTapped(for: photo)
                }
                .sheet(
                    item: $bStore.selectedPhoto) { selected in
                    InfoSheet(title: selected.title, author: selected.author, date: selected.date)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

private struct InfoSheet: View {
    let title: String
    let author: String
    let date: String
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
            Text(author)
            Text(date)
        }
        .font(.callout)
        .bold()
        .foregroundStyle(.white)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(.black))
    }
}

private struct PhotoCard: View {
    let imageURL: String
    let action: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                CardImage(url: URL(string: imageURL), placeholderText: "Photos not available")
            }
            
            Button {
                action()
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.title)
            }
            .bold()
            .foregroundStyle(.white)
            .background(Circle().fill(.black))
            .padding(8)
        }
    }
}
