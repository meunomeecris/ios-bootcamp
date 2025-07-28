import Foundation

final class RecipeClientLive: RecipeClient {
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

        // Decode Data
        let decoder = JSONDecoder()
        let categoryData = try decoder.decode(RecipeCategory.self, from: data)

        return categoryData
    }

    func getMeals(for category: String) async throws -> RecipeMeal {
        // API URL
        let api = "https://www.themealdb.com/api/json/v1/1/filter.php?"
        var components = URLComponents(string: api)
        components?.queryItems = [URLQueryItem(name: "c", value: category)]
        guard let url = components?.url else {
            print("Error: cannot create URL")
            throw URLError(.badURL)
        }

        // URL Request
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: urlRequest)

        // Decode Data
        let decoder = JSONDecoder()
        let mealData = try decoder.decode(RecipeMeal.self, from: data)

        return mealData
    }
}


final class RecipeClientSucess: RecipeClient {
    func getCategories() async throws -> RecipeCategory {
        return RecipeCategory(
            categories: [
                Category(
                    id: "3",
                    strCategory: "Vegan",
                    strCategoryThumb: "https://upload.wikimedia.org/wikipedia/commons/5/5b/Vegan_friendly_icon.svg",
                    strCategoryDescription: "Le végétarisme exclue les produits issus de l'abattage des animaux")
            ]
        )
    }
    
    func getMeals(for category: String) async throws -> RecipeMeal {
        return RecipeMeal(meals: [Meal(strMeal: "Quiche vegan", strMealThumb: "https://img.cuisineaz.com/660x495/2022/01/28/i182754-shutterstock-188567105.webp", idMeal: "6")])
    }
}


final class RecipeClientFailed: RecipeClient {
    func getCategories() async throws -> RecipeCategory {
        throw URLError(.badURL)
    }

    func getMeals(for category: String) async throws -> RecipeMeal {
        throw URLError(.badServerResponse)
    }
}
