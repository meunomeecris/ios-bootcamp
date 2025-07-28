import Foundation

@MainActor
@Observable
final class HandlingAPIErrorStore {
    let clientAPI = HandlingAPIError()
    var showAlert: Bool = false
    var messageError: String = ""
    
    func loadData() {
        Task {
            do {
                try await clientAPI.fetchData()
            } catch let error as APIError {
                messageError = error.message
                showAlert = true
            } catch {
                messageError = "Inespected error: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}



