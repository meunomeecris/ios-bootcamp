//  Created by Cris Messias on 28/07/25.

import Foundation

final class GetPhotoClientMock: GetPhotoClient {
    func getPhoto() async throws -> [PrintPhoto] {
        try await Task.sleep(for: .seconds(3))
        
         return [
            PrintPhoto(
                id: "0", 
                author: "Alejandro Escamilla", 
                width: 5000, 
                height: 3333, 
                url: "https://unsplash.com/photos/yC-Yzbqy7PY", 
                downloadURL: "https://picsum.photos/id/0/5000/3333"
            ),
            PrintPhoto(
                id: "1", 
                author: "Alejandro Escamilla", 
                width: 5000, 
                height: 3333, 
                url: "https://unsplash.com/photos/LNRyGwIJr5c",
                downloadURL: "https://picsum.photos/id/1/5000/3333",
                isSelected: true
            )
         ]
    }
}
