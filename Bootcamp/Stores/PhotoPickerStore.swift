import Foundation
import SwiftUI
import PhotosUI

@MainActor
@Observable final class PhotoPickerStore {
    private(set) var showSingleImage: UIImage? = nil
    private(set) var showMultipleImages: [UIImage] = []
    
    var pickerSingleImage: PhotosPickerItem? = nil {
        didSet {
            setSingleUIimage(from: pickerSingleImage)
        }
    }
    var pickerMultipleImages: [PhotosPickerItem] = [] {
        didSet {
            setMultipleUIimages(from: pickerMultipleImages)
        }
    }
    
    func removeAllPhotos() {
        showSingleImage = nil
        showMultipleImages.removeAll()
    }
    
    private func setSingleUIimage(from selection: PhotosPickerItem?) {
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
    
    private func setMultipleUIimages(from selections: [PhotosPickerItem]) {
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
//        multipleImages = []
    }
}
