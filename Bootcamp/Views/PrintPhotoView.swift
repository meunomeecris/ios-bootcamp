//  Created by Cris Messias on 28/07/25.

import SwiftUI

struct PrintPhotoView: View {
    @Bindable var store: PrintPhotoStore
    let columns = [GridItem(.adaptive(minimum: 100)), GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        NavigationStack {
            if store.isPhotosLoading {
                ProgressView("Loading...")
            } else if let error = store.messageError {
                Text(error)
            } else {
                ListPrintPhoto()
            }
        }
    }
    
    @ViewBuilder
    func ListPrintPhoto() -> some View {
        List($store.allPhotos) { photo  in
            if let indice = store.allPhotos.firstIndex(where: { $0.id == photo.id }) {
                NavigationLink { 
                    PrintPhotoDetails(
                        photo: $store.allPhotos[indice],
                        title: $store.titleOrderInput) { 
                            store.createOrderPrintPhoto(with: store.allPhotos[indice])
                        }
                } label: { 
                    PrintPhotoCard(
                        image:  store.allPhotos[indice].downloadURL, 
                        author:  store.allPhotos[indice].author, 
                        isSelected:  store.allPhotos[indice].isSelected
                    )
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    PrintPhotoView(store: PrintPhotoStore(
        clientGet: GetPhotoClientMock(), 
        clientPost: PostPrintClientLive()
    ))
}




