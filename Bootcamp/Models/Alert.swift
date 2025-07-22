import Foundation
import SwiftUI

struct Alert: Identifiable {
    var id = UUID()
    let name: String
    let message: String
    let fontColor: Color
    let backgroundColor: Color
}


extension Alert {
    static var allCases: [Alert] = [
        Alert(
            name: AlertType.success.rawValue,
            message: AlertType.success.message,
            fontColor: .white,
            backgroundColor: .green
        ),
        Alert(
            name: AlertType.error.rawValue,
            message: AlertType.error.message,
            fontColor: .white,
            backgroundColor: .pink
        ),
        Alert(
            name: AlertType.alert.rawValue,
            message: AlertType.alert.message,
            fontColor: .black,
            backgroundColor: .yellow
        )
    ]
}
