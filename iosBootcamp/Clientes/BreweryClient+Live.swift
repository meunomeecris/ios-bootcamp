import Foundation

class BreweryClientLive {
    
    func getBreweries() async throws -> [Brewery] {
        
        //URLRequest
        let api = "https://api.openbrewerydb.org/v1/breweries"
        let country = "france"
        var components = URLComponents(string: api)
        components?.queryItems = [URLQueryItem(name: "by_country", value: country), URLQueryItem(name: "_page", value: "3")]
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        print(url)
        let urlRequest = URLRequest(url: url)
        
        
        //Call the Resquest
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard response is HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        //Decode Data
        let decoder = JSONDecoder()
        let breweryData = try decoder.decode([Brewery].self, from: data)
        
        print(breweryData.first!)
        
        return breweryData
    }
}
