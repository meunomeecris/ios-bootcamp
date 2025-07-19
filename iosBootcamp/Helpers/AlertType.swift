import Foundation

enum AlertType: String {
    case success = "Success"
    case error = "Error"
    case alert = "Alert"
    
    var message: String {
        switch self {
        case .success:
            return "You annoyed your best friend!"
        case .error:
            return "They must me sleeping, try again!"
        case .alert:
            return "Be careful, you are play with fire!"
        }
    }
}
