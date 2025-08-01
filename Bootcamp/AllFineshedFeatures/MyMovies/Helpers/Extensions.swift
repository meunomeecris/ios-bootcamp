//  Created by Cris Messias on 31/07/25.

import Foundation

extension Movie {
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}


extension Movie {
    static var preview = Movie(
        id: 27205,
        title: "Inception",
        overview: """
        Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: "inception", the implantation of another person's idea into a target's subconscious.
        """,
        posterPath: "/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg",
        isFavorite: false
    )
}
