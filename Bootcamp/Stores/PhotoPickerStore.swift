import Foundation
import SwiftUI
import PhotosUI

@MainActor
@Observable final class PhotoPickerStore {
    private(set) var showSingleImage: UIImage? = nil
    var singleImage: PhotosPickerItem? = nil {
        didSet {
            setSingleImage(from: singleImage)
        }
    }
    
    private func setSingleImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }

        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                showSingleImage = uiImage
            } catch {
                print(error)
            }

        }
    }
    
    
    private(set) var showMultipleImages: [UIImage] = []
    var multipleImages: [PhotosPickerItem] = [] {
        didSet {
            setMultipleImages(from: multipleImages)
        }
    }
    
    private func setMultipleImages(from selections: [PhotosPickerItem]) {
        Task {
           for selection in selections {
                do {
                    let data = try await selection.loadTransferable(type: Data.self)
                    guard let data, let uiImage = UIImage(data: data) else {
                        throw URLError(.badServerResponse)
                    }
                    showMultipleImages.append(uiImage)
                } catch {
                    print(error)
                }
            }
        }
    }
}
