//  Created by Cris Messias on 28/07/25.

import SwiftUI

struct PrintPhotoRoot: View {
    let store: PrintPhotoStore
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    Tab("Photos", systemImage: "photo") {
                        PrintPhotoView(store: store)
                    }
                    Tab("Panier", systemImage: "cart") { 
                        PrintPhotoPanier(store: store)
                    }
                }
            }
            .navigationTitle("Photo Print")
        }
    }
}

#Preview {
    PrintPhotoRoot(store: PrintPhotoStore(
        clientGet: GetPhotoClientMock(), 
        clientPost: PostPrintClientLive()
    ))
}
