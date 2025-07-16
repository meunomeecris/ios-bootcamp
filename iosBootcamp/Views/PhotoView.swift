import SwiftUI

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
    PhotoView(store: PhotoStore())
}

struct GaleryPhoto: View {
    let store: PhotoStore
    let columns = [GridItem(.adaptive(minimum: 100)), GridItem(.adaptive(minimum: 100))]
    @Bindable var bStore: PhotoStore
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(store.photos) { photo in
                PhotoCard(
                    image_url: photo.imageURL,
                    action: {
                        store.infosButtonTapped(for: photo)
                    })
                .sheet(
                    item: $bStore.selectedPhoto) { selected in
                        InfoSheet(title: selected.title, author: selected.author, date: selected.date)
                    }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct InfoSheet: View {
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

struct PhotoCard: View {
    let image_url: String
    let action: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            VStack {
                AsyncImage(url: URL(string: image_url)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                    Text("Photos not available")
                        .font(.callout)
                        .bold()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            
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

