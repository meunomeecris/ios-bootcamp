import SwiftUI

struct Root: View {
    private let galeryStore = GaleryPhotosStore(galeryPhotosClient: GaleryPhotosMock())
    private let catStore = CatPhotoStore(catClient: CatPhotoLive())
    private let breweryStore = BreweryStore(breweryClient: BreweryClientLive())
    private let recipeStore = RecipeStore(recipeClient: RecipeClientLive())
    private let locationStore = LocationStore()
    private let productStore = ProductStore(productClient: ProductClientMock())
    private let alertStore = AlertStore()
    private let taskStore = TaskStore()
    private let petBookStore = PetBookStore(petClient: PetClientMock())
    private let photoPickerStore = PhotoPickerStore()
    private let newsStore = NewsStore(client: NewsClientLive())
    
    
    var body: some View {
        NavigationStack {
            List(RootNavigation.allCases) { project in
                NavigationLink(project.title) {
                    destination(for: project)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("🚀 Mini Projects")
        }
        
    }
    
    @ViewBuilder
    func destination(for project: RootNavigation) -> some View {
        switch project {
        case .galeryParis:
            GaleryPhotosView(store: galeryStore)
        case .galeryCats:
            CatPhotoView(store: catStore)
        case .brewery:
            BreweryView(store: breweryStore)
        case .recipes:
            RecipeView(store: recipeStore)
        case .location:
            LocationView(store: locationStore)
        case .products:
            ProductView(store: productStore)
        case .alerts:
            AlertView(store: alertStore)
        case .tasks:
            TaskView(store: taskStore)
        case .petbook:
            PetBookView(store: petBookStore)
        case .photoPicker:
            PhotoPickerView(store: photoPickerStore)
        case .news:
            ///Fix: Store the searchText to return a search on the mean view
            NewsView(store: newsStore)
        }
    }
}

#Preview {
    Root()
}
