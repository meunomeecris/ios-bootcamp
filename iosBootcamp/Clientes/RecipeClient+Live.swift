import Foundation

final class RecipeClientLive {
    
    func getCategories() async throws -> RecipeCategory {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
            print("Error: cannot create URL")
            throw URLError(.badURL)
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard response is HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        //Decode Data
        let decoder = JSONDecoder()
        let categoryData = try decoder.decode(RecipeCategory.self, from: data)
        
        return categoryData
    }
    
    
    func getMeals(for category: String) async throws  -> RecipeMeal {
        //API URL
        let api = "https://www.themealdb.com/api/json/v1/1/filter.php?"
        var components = URLComponents(string: api)
        components?.queryItems = [URLQueryItem(name: "c", value: category)]
        guard let url = components?.url else {
            print("Error: cannot create URL")
            throw URLError(.badURL)
        }
        
        //URL Request
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        //Decode Data
        let decoder = JSONDecoder()
        let mealData = try decoder.decode(RecipeMeal.self, from: data)
        
        return mealData
    }
    
}
