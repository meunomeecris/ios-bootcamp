import Foundation
import AVFoundation
import SwiftUI

@Observable
final class AlertStore {
    var showingAlert: Bool = false
    var selectedAlert: Alert?
    var alertsData: [Alert] = Alert.allCases

    func onShowAlertTapped(for alert: Alert) async throws {
        try await Task.sleep(for: .seconds(3))
        showingAlert = true
        selectedAlert = alert
        playSound()
    }

    func dismissButtonAlert() {
        showingAlert = false
    }

    private func playSound() {
        AudioServicesPlaySystemSound(1003)
    }
}
