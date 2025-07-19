import SwiftUI

struct AlertView: View {
    let store: AlertStore
    
    var body: some View {
        @Bindable var bStore = store
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 32) {
                Text("Alerts")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                
                Spacer()
                
                ForEach(store.alertsData) { alert in
                    ButtonAlert(
                        name: alert.name,
                        color: alert.fontColor,
                        bgColor: alert.backgroundColor) {
                            store.onShowAlertTapped(for: alert)
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

private struct ButtonAlert: View {
    let name: String
    let color: Color
    let bgColor: Color
    let action: ()->Void
    var body: some View {
        Button(name, systemImage: "bell.fill") {
            action()
        }
        .font(.body)
        .textCase(.uppercase)
        .bold()
        .foregroundStyle(color)
        .padding(16)
        .frame(width: 200)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(bgColor)
                .shadow(color: bgColor.opacity(0.3), radius:1, x:10, y:10)
        )
    }
}
