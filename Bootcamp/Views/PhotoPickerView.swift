import SwiftUI
import PhotosUI
import UIComponents

struct PhotoPickerView: View {
    @Bindable var store = PhotoPickerStore()
    
    var body: some View {
        VStack(spacing: 40) {
            TitleViewComponent(title: "Photo's Selection")
            PhotoPickerButton(store: store)
            Divider()
            PhotoVisualizer(store: store)
            Spacer()
        }
    }
}

#Preview {
    PhotoPickerView()
}


private struct PhotoPickerButton: View {
    @Bindable var store: PhotoPickerStore
    
    var body: some View {
        HStack {
            PhotosPicker(selection: $store.pickerSingleImage, matching: .images) {
                Text("One Photo")
            }
            .foregroundStyle(.white)
            .bold()
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.red))
            
            PhotosPicker(selection: $store.pickerMultipleImages, matching: .images) {
                Text("Multiple Photos")
            }
            .foregroundStyle(.black)
            .bold()
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.yellow))
            
        }
            Button("Clear all photos") {
                store.removeAllPhotos()
            }
            .foregroundStyle(.white)
            .bold()
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                   
    }
}


private struct PhotoVisualizer: View {
    let store: PhotoPickerStore
    
    var body: some View {
        if store.showMultipleImages.isEmpty && store.showSingleImage == nil {
            Text("No photos selected")
                .font(.title3)
                .foregroundStyle(.gray)
        } else {
            if let image = store.showSingleImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green, lineWidth: 2)
                    )
            }
            
            if !store.showMultipleImages.isEmpty {
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(store.showMultipleImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}
