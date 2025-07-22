import SwiftUI

struct LocationView: View {
    let store: LocationStore
    var body: some View {
        VStack(spacing: 20) {
            if let location = store.userLocation {
                Text("Latitude: \(location.latitude), Longitude: \(location.longitude)")
                    .font(.title2)
            } else if let error = store.errorMessage {
                Text("Erro: \(error)")
                    .foregroundColor(.red)
            } else {
                Text("Buscando localização...")
            }
        }
        .onAppear {
            store.currentLocation()
        }
    }
}

#Preview {
    LocationView(store: LocationStore())
}
