//  Created by Cris Messias on 28/07/25.

import Foundation

protocol GetPhotoClient {
    func getPhoto() async throws -> [PrintPhoto]
}


