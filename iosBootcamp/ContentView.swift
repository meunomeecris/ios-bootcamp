import SwiftUI

struct ContentView: View {
    var body: some View {
//        PhotoView(store: PhotoStore())
//        CatView(store: CatStore())
        BreweryView(store: BreweryStore())
    }
}

#Preview {
    ContentView()
}
