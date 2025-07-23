import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @Bindable var store = PhotoPickerStore()
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Potho Picker")
                .font(.largeTitle)
                .bold()
            
            HStack {
                PhotosPicker(selection: $store.singleImage, matching: .images) {
                    Text("One Photo")
                }
                .foregroundStyle(.white)
                .bold()
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(.indigo))
                
                PhotosPicker(selection: $store.multipleImages, matching: .images) {
                    Text("Multiple Photos")
                }
                .foregroundStyle(.white)
                .bold()
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(.black))
            }
            
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
            
            Spacer()
        }
    }
}

#Preview {
    PhotoPickerView()
}
