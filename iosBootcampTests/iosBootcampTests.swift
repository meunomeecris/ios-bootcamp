import Testing
@testable import iosBootcamp

struct iosBootcampTests {

    @Suite("Brewery Store Tests")
    struct BreweryStoreTests {
        @Test("Brewery Store") func loadBreweries() async {
            let store = await BreweryStore(breweryClient: BreweryClientSucess())
            
            await store.loadBreweries()
            
            await #expect(store.isLoding == false)
            await #expect(!store.breweries.isEmpty)
            await #expect(store.errorMessage == nil)
        }
        
        @Test("Brewery Store") func loadBreweriesCatchError() async {
            let store = await BreweryStore(breweryClient: BreweryClientFailed())
            
            await store.loadBreweries()
            
            await #expect(store.isLoding == false)
            await #expect(store.breweries.isEmpty)
            await #expect(store.errorMessage != nil)
        }
    }
    
    @Suite("Product Store")
    struct ProductStoreTests {
        @Test func loadProductsSucess() async {
            let store = await ProductStore(productClient: ProductClientSucess())
            
            await store.fecthProducts()
            
            await #expect(store.isLoading == false)
            await #expect(!store.products.isEmpty)
            await #expect(store.errorMessage == nil)
        }
        
        @Test func loadProductsFailed() async {
            let store = await ProductStore(productClient: ProductClientFailed())
            
            await store.fecthProducts()
            
            await #expect(store.isLoading == false)
            await #expect(store.products.isEmpty)
            await #expect(store.errorMessage != nil)
        }
    }
    
    @Suite("Cat Store")
    struct CatStoreTests {
        @Test func loadCatsSucess() async {
            let store = await CatStore(catClient: CatClientSucess())
            
            await store.loadCats()
            
            await #expect(store.isLoading == false)
            await #expect(!store.cats.isEmpty)
            await #expect(store.errorMessage == nil)
        }
        
        @Test func loadCatsFailed() async {
            let store = await CatStore(catClient: CatClientFailed())
            
            await store.loadCats()
            
            await #expect(store.isLoading == false)
            await #expect(store.cats.isEmpty)
            await #expect(store.errorMessage != nil)
        }
    }
    
    @Suite("Recipe Store")
    struct RecipeStoreTests {
        @Test func loadRecipeSucess() async {
            let store =  await RecipeStore(recipeClient: RecipeClientSucess())
            
            await store.loadCategories()
            await store.loadMeals()
            
            await #expect(!store.categoriesData.isEmpty)
            await #expect(!store.mealsData.isEmpty)
            await #expect(store.isLoadingCategories == false)
            await #expect(store.erroMessage == nil)
        }
        
        @Test func loadRecipeFailed() async throws {
            let store = await RecipeStore(recipeClient: RecipeClientFailed())
            
            await store.loadCategories()
            await store.loadMeals()
            
            await #expect(store.categoriesData.isEmpty)
            await #expect(store.mealsData.isEmpty)
            await #expect(store.isLoadingCategories == false)
            await #expect(store.erroMessage != nil)
        }
    }
    
    @Suite("Photo Store")
    struct PhotoStoreTests {
        @Test func loadPhotoSuccess() async  {
            let store = await PhotoStore(photoClient: PhotoClientSucess())
            
            await store.loadPhotos()
            
            await #expect(store.isLoading == false)
            await #expect(!store.photos.isEmpty)
            await #expect(store.errorMessage == nil)
        }
        
        @Test func loadPhotoFailed() async {
            let store = await PhotoStore(photoClient: PhotoClientFailed())
            
            await store.loadPhotos()
            
            await #expect(store.isLoading == false)
            await #expect(store.photos.isEmpty)
            await #expect(store.errorMessage != nil)
        }
        
        @Test func infosButtonTapped() async {
            let store = await PhotoStore(photoClient: PhotoClientSucess())
            await store.loadPhotos()
            let photo = await store.photos.first!
            
            await store.infosButtonTapped(for: photo)
            
            await #expect(store.selectedPhoto == photo)
        }
        
        @Test func didDismiss() async {
            let store = await PhotoStore(photoClient: PhotoClientSucess())
            await store.loadPhotos()
            let photo = await store.photos.first!
            
            await store.infosButtonTapped(for: photo)
            await store.didDismiss()
            await #expect(store.selectedPhoto == nil)
        }
    }
    
    @Suite("Alert Store")
    struct AlertStoreTests {
        @Test func showAlert() {
            let store = AlertStore()
            store.onShowAlertTapped(for: store.alertsData.first!)
            #expect(store.showingAlert == true)
            #expect(store.selectedAlert != nil)
        }
        
        @Test func dismissAlert() {
            let store = AlertStore()
            store.dismissButtonAlert()
            #expect(store.showingAlert == false)
            #expect(store.selectedAlert == nil)
        }
    }
}
