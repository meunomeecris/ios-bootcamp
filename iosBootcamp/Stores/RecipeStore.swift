import Foundation

@MainActor
@Observable final class RecipeStore {
    private let clientRecipe = RecipeClientLive()
    
    var categoriesData: [Category] = []
    var mealsData: [Meal] = []
    var selectedCategory: Category? = nil
    var erroMessage: String?
    var isLoadingCategories: Bool = false
    
    func loadCategories() async {
        do {
            let result = try await clientRecipe.getCategories()
            categoriesData = result.categories
            selectedCategory = categoriesData.first
        } catch {
            erroMessage = "Fail to load categories \(error.localizedDescription)"
        }
    }
    
    func searchMealByCategory() {
        Task {
            await loadMeals()
        }
    }
    
    func loadMeals() async {
        guard let category = selectedCategory else { return }
        
        do {
            let meals = try await clientRecipe.getMeals(for: category.strCategory)
            mealsData = meals.meals
        } catch {
            erroMessage = "Fail to load meals \(error.localizedDescription)"
        }
    }
}
