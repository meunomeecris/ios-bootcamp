//  Created by Cris Messias on 28/07/25.

import SwiftUI

struct PrintPhotoPanier: View {
    let store: PrintPhotoStore
    
    var body: some View {
        if !store.orderPrintPhotos.isEmpty {
            List(store.selectedAllPhotos) { photo in
                PrintPhotoCard(
                    image: photo.downloadURL,
                    author: photo.author,
                    isSelected: photo.isSelected
                )
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            Button("Order print") {
                store.OrderPrintPhotos()
            }
            .navigationBarTitle("Panier")
        } else {
            Text("No selected photos")
        }
    }
}

#Preview {
    PrintPhotoPanier(store: PrintPhotoStore(
        clientGet: GetPhotoClientMock(), 
        clientPost: PostPrintClientLive()
    ))
}
