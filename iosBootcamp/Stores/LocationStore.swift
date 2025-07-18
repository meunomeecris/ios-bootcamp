import Foundation

@MainActor
@Observable final class LocationStore {
    private let locationClient = LocationClientLive()
    
    var userLocation: Location? = nil
    var errorMessage: String? = nil
    
    func currentLocation() {
        locationClient.onLocationUpdate = { [weak self] coordinate in
            self?.userLocation = Location(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
        
        locationClient.onError = { [weak self] error in
            self?.errorMessage = error.localizedDescription
        }
    }
}
