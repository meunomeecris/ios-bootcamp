import SwiftUI

struct Root: View {
    var body: some View {
        NavigationStack {
            List {
                Group {
                    NavigationLink("Load Random Photos") {
                        PhotoView(store: PhotoStore(photoClient: PhotoClientMock()))
                    }
                    NavigationLink("Load Cats Photos") {
                        CatView(store: CatStore(catClient: CatClientLive()))
                    }
                    NavigationLink("Load Brewery in France") {
                        BreweryView(store: BreweryStore(breweryClient: BreweryClientLive()))
                    }
                    NavigationLink("Search for Recipes") {
                        RecipeView(store: RecipeStore(recipeClient: RecipeClientLive()))
                    }
                    NavigationLink("Get you location") {
                        LocationView(store: LocationStore())
                    }
                    NavigationLink("Load Sport Products") {
                        ProductView(store: ProductStore(productClient: ProductClientMock()))
                    }
                    NavigationLink("Show Alerts") {
                        AlertView(store: AlertStore())
                    }
                    NavigationLink("Task Tracker") {
                        TaskView(store: TaskStore())
                    }
                    NavigationLink("PetBook Photos") {
                        PetBookView(store: PetBookStore(petClient: PetClientMock()))
                    }
                    NavigationLink("Picker Photos") {
                        PhotoPickerView(store: PhotoPickerStore())
                    }
                }
                .listRowSeparator(.hidden)

            }
            .listStyle(.plain)
            .navigationTitle("🚀 Mini Projects")
        }
    }
}

#Preview {
    Root()
}
