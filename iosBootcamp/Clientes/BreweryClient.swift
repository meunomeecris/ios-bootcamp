protocol BreweryClient {
    func getBreweries() async throws -> [Brewery]
}
