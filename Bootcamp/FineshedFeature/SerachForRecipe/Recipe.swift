import Foundation

struct RecipeCategory: Codable {
    let categories: [Category]
}

struct Category: Identifiable, Codable, Hashable {
    let id: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String

    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case strCategory
        case strCategoryThumb
        case strCategoryDescription
    }
}


struct RecipeMeal: Codable {
    let meals: [Meal]
}

struct Meal: Identifiable, Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String

    var id: String { idMeal }

    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
}
