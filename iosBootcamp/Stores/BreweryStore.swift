import Foundation

@MainActor
@Observable final class BreweryStore {
    private var breweryClient = BreweryClientLive()
    
    var breweries: [Brewery] = []
    var isLoding: Bool = false
    var errorMessage: String?
    
    func loadBreweries() async {
        isLoding = true
        
        do {
            breweries = try await breweryClient.getBreweries()
        } catch {
            errorMessage = "Failed to load breweries: \(error.localizedDescription)"
        }
        
        isLoding = false
    }
}
