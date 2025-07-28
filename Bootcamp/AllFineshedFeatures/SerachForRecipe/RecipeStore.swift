import Foundation

@MainActor
@Observable
final class RecipeStore {
    private let recipeClient: RecipeClient

    init(client: RecipeClient) {
        self.recipeClient = client
    }

    var categoriesData: [Category] = []
    var mealsData: [Meal] = []
    var selectedCategory: Category?
    var erroMessage: String?
    var isLoadingCategories: Bool = false

    func loadCategories() async {
        do {
            let result = try await recipeClient.getCategories()
            categoriesData = result.categories
            selectedCategory = categoriesData.first
        } catch {
            erroMessage = "Fail to load categories \(error.localizedDescription)"
        }
    }

    func loadMeals() async {
        guard let category = selectedCategory else { return }

        do {
            let meals = try await recipeClient.getMeals(for: category.strCategory)
            mealsData = meals.meals
        } catch {
            erroMessage = "Fail to load meals \(error.localizedDescription)"
        }
    }

    func searchMealByCategory() {
        Task {
            await loadMeals()
        }
    }
}
