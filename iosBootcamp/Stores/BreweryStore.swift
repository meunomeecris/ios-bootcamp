import Foundation

@MainActor
@Observable final class BreweryStore {
    private let breweryClient: BreweryClient
    
    init(breweryClient: BreweryClient) {
        self.breweryClient = breweryClient
    }
    
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
