//  Created by Cris Messias on 31/07/25.

import Foundation

func getMovieAPIKey() -> String? {
    guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
          let dict = NSDictionary(contentsOfFile: path),
          let apiKey = dict["apiKeyTMDB"] as? String else {
        return nil
    }
    return apiKey
}
