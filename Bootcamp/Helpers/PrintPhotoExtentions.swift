//
//  PrintPhotoExtentions.swift
//  Bootcamp
//
//  Created by Cris Messias on 28/07/25.
//

import Foundation

extension PrintPhoto {
    static var preview: PrintPhoto {
        return PrintPhoto(
            id: "0", 
            author: "Alejandro Escamilla", 
            width: 5000, 
            height: 3333, 
            url: "https://unsplash.com/photos/yC-Yzbqy7PY", 
            downloadURL: "https://picsum.photos/id/0/5000/3333",
        )
    }
}
