protocol RecipeClient {
    func getCategories() async throws -> RecipeCategory
    func getMeals(for category: String) async throws -> RecipeMeal
}
