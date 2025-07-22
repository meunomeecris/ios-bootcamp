import SwiftUI

struct Root: View {
    var body: some View {
        //        PhotoView(store: PhotoStore())
        //        CatView(store: CatStore())
        //        BreweryView(store: BreweryStore())
        //        RecipeView(store: RecipeStore())
        //        LocationView(store: LocationStore())
        //        ProductView(store: ProductStore(productClient: ProductClientMock()))
//        AlertView(store: AlertStore())
//        TaskView(store: TaskStore())
        PetBookView(store: PetBookStore(petClient: PetClientMock()))
    }
}

#Preview {
    Root()
}
