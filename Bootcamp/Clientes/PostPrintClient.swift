//  Created by Cris Messias on 28/07/25.

import Foundation

protocol PostPrintClient {
    func sendOrder(for order: [OrderPrintPhoto]) async throws
}
