import Testing
import Foundation
@testable import Bootcamp

struct BootcampTests {
    @Suite("Brewery Store Tests")
    struct BreweryStoreTests {
        @Test
        func loadBreweries() async {
            let store = await BreweryStore(breweryClient: BreweryClientSucess())
            
            await store.loadBreweries()
            
            await #expect(store.isLoding == false)
            await #expect(!store.breweries.isEmpty)
            await #expect(store.errorMessage == nil)
        }
        
        @Test
        func loadBreweriesCatchError() async {
            let store = await BreweryStore(breweryClient: BreweryClientFailed())
            
            await store.loadBreweries()
            
            await #expect(store.isLoding == false)
            await #expect(store.breweries.isEmpty)
            await #expect(store.errorMessage != nil)
        }
    }
    
    @Suite("Product Store")
    struct ProductStoreTests {
        @Test
        func loadProductsSucess() async {
            let store = await ProductStore(productClient: ProductClientSucess())
            
            await store.fecthProducts()
            
            await #expect(store.isLoading == false)
            await #expect(!store.products.isEmpty)
            await #expect(store.errorMessage == nil)
        }
        
        @Test
        func loadProductsFailed() async {
            let store = await ProductStore(productClient: ProductClientFailed())
            
            await store.fecthProducts()
            
            await #expect(store.isLoading == false)
            await #expect(store.products.isEmpty)
            await #expect(store.errorMessage != nil)
        }
    }
    
    @Suite("Cat Store")
    struct CatStoreTests {
        @Test
        func loadCatsSucess() async {
            let store = await CatStore(catClient: CatClientSucess())
            
            await store.loadCats()
            
            await #expect(store.isLoading == false)
            await #expect(!store.cats.isEmpty)
            await #expect(store.errorMessage == nil)
        }
        
        @Test
        func loadCatsFailed() async {
            let store = await CatStore(catClient: CatClientFailed())
            
            await store.loadCats()
            
            await #expect(store.isLoading == false)
            await #expect(store.cats.isEmpty)
            await #expect(store.errorMessage != nil)
        }
    }
    
    @Suite("Recipe Store")
    struct RecipeStoreTests {
        @Test
        func loadRecipeSucess() async {
            let store = await RecipeStore(recipeClient: RecipeClientSucess())
            
            await store.loadCategories()
            await store.loadMeals()
            
            await #expect(!store.categoriesData.isEmpty)
            await #expect(!store.mealsData.isEmpty)
            await #expect(store.isLoadingCategories == false)
            await #expect(store.erroMessage == nil)
        }
        
        @Test
        func loadRecipeFailed() async throws {
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
        @Test
        func loadPhotoSuccess() async {
            let store = await PhotoStore(photoClient: PhotoClientSucess())
            
            await store.loadPhotos()
            
            await #expect(store.isLoading == false)
            await #expect(!store.photos.isEmpty)
            await #expect(store.errorMessage == nil)
        }
        
        @Test
        func loadPhotoFailed() async {
            let store = await PhotoStore(photoClient: PhotoClientFailed())
            
            await store.loadPhotos()
            
            await #expect(store.isLoading == false)
            await #expect(store.photos.isEmpty)
            await #expect(store.errorMessage != nil)
        }
        
        @Test
        func infosButtonTapped() async throws {
            let store = await PhotoStore(photoClient: PhotoClientSucess())
            await store.loadPhotos()
            let unwrappedPhoto = try await #require(store.photos.first)
            
            await store.infosButtonTapped(for: unwrappedPhoto)
            
            await #expect(store.selectedPhoto == unwrappedPhoto)
        }
        
        @Test
        func didDismiss() async throws {
            let store = await PhotoStore(photoClient: PhotoClientSucess())
            await store.loadPhotos()
            let unwrappedPhoto = try await #require(store.photos.first)
            await store.infosButtonTapped(for: unwrappedPhoto)
            await store.didDismiss()
            await #expect(store.selectedPhoto == nil)
        }
    }
    
    @Suite("Alert Store")
    struct AlertStoreTests {
        @Test
        func showAlert() async throws {
            let store = AlertStore()
            let unwrappedAlert = try #require(store.alertsData.first)
            try await store.onShowAlertTapped(for: unwrappedAlert)
            #expect(store.showingAlert == true)
            #expect(store.selectedAlert != nil)
        }
        
        @Test
        func dismissAlert() {
            let store = AlertStore()
            store.dismissButtonAlert()
            #expect(store.showingAlert == false)
            #expect(store.selectedAlert == nil)
        }
    }
    
    @Suite("Tasks Tracker Store")
    struct TasksTrackerStoreTests {
        let store = TaskStore()
        
        @Test func filteredTasksSuccess()  {
            store.userTasks = [
                    TaskTracker(title: "A", date: Date(), isCompleted: false),
                    TaskTracker(title: "B", date: Date(), isCompleted: true),
                    TaskTracker(title: "C", date: Date(), isCompleted: false)
                ]

                store.currentFilter = .all
                #expect(store.filteredTasks.count == 3)

                store.currentFilter = .completed
                #expect(store.filteredTasks.count == 1)

                store.currentFilter = .pending
                #expect(store.filteredTasks.count == 2)

                store.currentFilter = .today
                #expect(store.filteredTasks.count == 3)
        }
        
        @Test func addTaskSuccess() async throws {
            store.addTask()
            let count = store.userTasks.count
            #expect(count < (count + 1))
            #expect(store.titleTaskInput.isEmpty)
        }
        
        @Test func completedTaskSucess() {
            store.userTasks = [
                TaskTracker(title: "A", date: Date(), isCompleted: false),
                TaskTracker(title: "B", date: Date(), isCompleted: true)
            ]
            store.completeTask(store.userTasks[0])
            #expect(store.userTasks[0].isCompleted == true)
            #expect(store.showAlertTaskCompleted == true)
        }
        
        @Test func removeAllSuccess() async throws {
            store.userTasks = [
                TaskTracker(title: "A", date: Date(), isCompleted: false),
                TaskTracker(title: "B", date: Date(), isCompleted: true)
            ]
            store.removeAllTasks()
            #expect(store.userTasks.isEmpty)
        }
    }
    
    @Suite("PetBook Tests")
    struct PetBookStoreTests {
        @Test func fetchPetSuccess() async throws {
            let store = await PetBookStore(petClient: PetClientSucess())
            try await store.fetchPet()
            await #expect(store.errorMessage == nil)
            await #expect(!store.pets.isEmpty)
        }
        
        @Test func fetchPetFailed() async throws {
            let store = await PetBookStore(petClient: PetClientFailed())
            try await store.fetchPet()
            await #expect(store.errorMessage != nil)
            await #expect(store.pets.isEmpty)
        }
        
        @Test func toogleFavoriteSuccess() async throws {
            let store = await PetBookStore(petClient: PetClientSucess())
            try await store.fetchPet()
            await store.toggleFavorite(for: store.pets[0])
            await #expect(store.pets[0].isFavorite == false)
        }
    }
}
