import SwiftUI
import UIComponents

struct LocationView: View {
    let store: LocationStore
    
    var body: some View {
        LoadableViewComponent(
            data: store.userLocation,
            errorMessage: store.errorMessage,
            loadingText: "Searching for your location..."
        ) { location in
            VStack(spacing: 12) {
                Text("Latitude: \(location.latitude)")
                Text("Longitude: \(location.longitude)")
            }
            .font(.title2)
        }
        .onAppear {
            store.currentLocation()
        }
    }
}

#Preview {
    LocationView(store: LocationStore())
}
