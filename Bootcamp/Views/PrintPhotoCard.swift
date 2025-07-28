//  Created by Cris Messias on 28/07/25.

import SwiftUI

struct PrintPhotoCard: View {
    var image: String
    var author: String
    var isSelected: Bool
    
    var body: some View { 
        VStack(alignment: .leading) {
            LoadPhotos()
            HStack {
                Label("\(author)", systemImage: "person.circle" )
                    .font(.title3)
                    .padding(.horizontal, 16)
                    .frame(height: 48)
                
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle.fill" : "")
                    .font(.title)
                    .padding()
                    .foregroundStyle(.black)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.yellow)
                .opacity(0.2)
        )
    }
    
    @ViewBuilder 
    func LoadPhotos() -> some View {
        AsyncImage(url: URL(string: image)) { phase in 
            if let image = phase.image {
                image 
                    .resizable()
                    .scaledToFit()
            } else if (phase.error != nil) {
                Image(.imageError)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            } else {
                Image(.imagePlaceholder)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
            }
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .overlay { 
            if isSelected {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.gray)
                    .opacity(0.6)
            }
        }
    }
}

//#Preview {
//    PrintPhotoCard(photo: PrintPhoto.preview)
//        .padding(16)
//}
