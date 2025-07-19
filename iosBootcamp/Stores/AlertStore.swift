import Foundation
import SwiftUI

@Observable final class AlertStore {
    var showingAlert: Bool = false
    var selectedAlert: Alert?
    
    var alertsData:[Alert] = Alert.allCases
    
    func onShowAlertTapped(for alert: Alert) {
        showingAlert = true
        selectedAlert = alert
    }
    
    func dismissButtonAlert() {
        showingAlert = false
    }
}
