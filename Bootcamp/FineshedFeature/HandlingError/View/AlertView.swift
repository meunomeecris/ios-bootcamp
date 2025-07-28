import SwiftUI
import UIComponents

struct AlertView: View {
    let store: AlertStore
    
    var body: some View {
        @Bindable var bStore = store
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 32) {
                TitleViewComponent(title: "Alerts")
                    .foregroundStyle(.white)
                Spacer()
                
                ForEach(store.alertsData) { alert in
                    ButtonAlert(
                        name: alert.name,
                        color: alert.fontColor,
                        bgColor: alert.backgroundColor) {
                            Task {
                                try await store.onShowAlertTapped(for: alert)
                            }
                        }
                }
                
                Spacer()
            }
        }
        .alert(bStore.selectedAlert?.name ?? "Notification", isPresented: $bStore.showingAlert) {
            Button("I got it!") {
                store.dismissButtonAlert()
            }
        } message: {
            Text(bStore.selectedAlert?.message ?? "")
        }
    }
}

#Preview {
    AlertView(store: AlertStore())
}
