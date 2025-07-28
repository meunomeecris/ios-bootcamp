import SwiftUI

struct Root: View {    
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
    
    
    private let galeryStore = ParisPhotoStore(client: ParisPhotoMock())
    private let catStore = CatPhotoStore(client: CatPhotoLive())
    private let breweryStore = BreweryStore(client: BreweryClientLive())
    private let recipeStore = RecipeStore(client: RecipeClientLive())
    private let locationStore = LocationStore()
    private let productStore = ProductStore(client: ProductClientMock())
    private let alertStore = AlertStore()
    private let taskStore = TaskStore()
    private let petBookStore = PetBookStore(client: PetClientMock())
    private let photoPickerStore = PhotoPickerStore()
    private let newsStore = NewsStore(client: NewsClientLive())
    private let printPhotoStore = PrintPhotoStore(
        clientGet: GetPhotoClientLive(),
        clientPost: PostPrintClientLive()
    )
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
        case .printPhoto:
            PrintPhotoRoot(store: printPhotoStore)
        }
    }
}

#Preview {
    Root()
}
