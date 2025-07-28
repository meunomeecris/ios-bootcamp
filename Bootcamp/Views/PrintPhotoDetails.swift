//  Created by Cris Messias on 28/07/25.

import SwiftUI

struct PrintPhotoDetails: View {
    @Binding var photo: PrintPhoto
    @Binding var title: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            PrintPhotoCard(
                image: photo.downloadURL, 
                author: photo.author, 
                isSelected: photo.isSelected
            ) 
            TextField("Add title", text: $title)
                .textFieldStyle(.roundedBorder)
            
            Button("Select this photo") {
                action()
                photo.isSelected = true
                title = ""
            }
        }
        .padding() 
    }
}

#Preview {
    PrintPhotoDetails(
        photo: .constant(PrintPhoto.preview), 
        title: .constant("Title"), 
        action: {}
        )
}
