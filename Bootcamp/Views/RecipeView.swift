import SwiftUI
import UIComponents

struct RecipeView: View {
    var store: RecipeStore

    var body: some View {
        ScrollView {
            VStack(spacing: 20 ) {
                TitleViewComponent(title: "Recipe")

                CategoryPicker(store: store)
                if let selected = store.selectedCategory {
                    Text(selected.strCategoryDescription)
                        .font(.callout)
                        .lineSpacing(5)
                }
                
                Divider()
                Spacer()

                Button(
                    "Search Meals",
                    systemImage: "magnifyingglass"
                ) {
                    store.searchMealByCategory()
                }

                Spacer()

                MealCard(
                    name: store.mealsData.first?.strMeal ?? "No data",
                    url: URL(string: store.mealsData.first?.strMealThumb ?? "https://i0.wp.com/lalignegourmande.fr/wp-content/uploads/2025/01/pomme-rouge-scaled.jpg?fit=2560%2C2560&ssl=1")
                )
            }
            .padding(16)
            .task {
                await store.loadCategories()
                await store.loadMeals()
            }
        }
    }
}

#Preview {
    RecipeView(store: RecipeStore(recipeClient: RecipeClientLive()))
}


private struct CategoryPicker: View {
    let store: RecipeStore

    var body: some View {
        @Bindable var bStore = store
        HStack {
            if let selected = store.selectedCategory {
                Text("Selected: \(selected.strCategory)")
                    .font(.headline)
            }
            if store.isLoadingCategories {
                ProgressView("Loading categories...")
            } else if let error = store.erroMessage {
                Text(error)
                    .font(.title3)
            } else {
                Picker("Categories", selection: $bStore.selectedCategory) {
                    ForEach(store.categoriesData, id: \.self) { category in
                        Text(category.strCategory)
                            .tag(category as Category?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
        }
    }
}


private struct MealCard: View {
    let name: String
    let url: URL?

    var body: some View {
        VStack {
            Text(name)
                .font(.title2)
                .bold()

            if let url = url {
                CardImageComponent(
                    url: url,
                    placeholderText: "Photos not available"
                )
            }
        }
        .padding()
        .background(.yellow.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}
