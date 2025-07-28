//  Created by Cris Messias on 28/07/25.

import Foundation

@MainActor
@Observable
final class PrintPhotoStore {
    private let clientGet: GetPhotoClient
    private let clientPost: PostPrintClient
    
    init(
        clientGet: GetPhotoClient,
        clientPost: PostPrintClient,
    ) {
        self.clientGet = clientGet
        self.clientPost = clientPost
        fetchPhotos()
    }
    
    var orderPrintPhotos: [OrderPrintPhoto] = []
    
    var allPhotos: [PrintPhoto] = []
    var isPhotosLoading: Bool = false
    var messageError: String?
    var titleOrderInput: String = ""
    var selectedAllPhotos: [PrintPhoto]  {
        return allPhotos.filter { $0.isSelected == true }
    }
    
    func createOrderPrintPhoto(with photo: PrintPhoto) {
        let order = OrderPrintPhoto(
            id: orderPrintPhotos.count + 1,
            total: selectedAllPhotos.count,
            photos: selectedAllPhotos,
            date: Date()
        )
        orderPrintPhotos.append(order)
    }
    
    func OrderPrintPhotos() {
        orderPrintPhotos.removeAll()
        Task {
            try await clientPost.sendOrder(for: orderPrintPhotos)
        }
    }
    
    private func fetchPhotos() {
        Task {
            isPhotosLoading = true
            do {
                allPhotos = try await clientGet.getPhoto()
            } catch {
                messageError = "Loading failed \(error.localizedDescription)"
            }
            isPhotosLoading = false
        }
    }
        
}
