import Foundation
import SwiftUI

enum RootNavigation: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case galeryParis
    case galeryCats
    case brewery
    case recipes
    case location
    case products
    case alerts
    case tasks
    case petbook
    case photoPicker
    case news
    case printPhoto
    
    var title: String {
        switch self {
        case .galeryParis: return "Galery Photos - Paris"
        case .galeryCats: return "Galery Photos - Cats"
        case .brewery: return "Load Brewery in France"
        case .recipes: return "Search for Recipes"
        case .location: return "Get your location"
        case .products: return "Load Sport Products"
        case .alerts: return "Show Alerts"
        case .tasks: return "Task Tracker"
        case .petbook: return "PetBook Photos"
        case .photoPicker: return "Picker Photos"
        case .news: return "Search News"
        case .printPhoto: return "Print Photos"
        }
    }
}
