import SwiftUI
import AVFoundation
import UIComponents

struct HandleAPIErrorView: View {
    @Bindable var store = HandlingAPIErrorStore()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                TitleViewComponent(title: "The 3rr0r")
                    .foregroundStyle(.white)
                Spacer()
                LoadableViewComponent(
                    data: store.loadData,
                    errorMessage: store.messageError,
                    loadingText: "Photos not available"
                ) {_ in
                    Button {
                        store.loadData()
                        AudioServicesPlayAlertSound(1030)
                    } label: {
                        Text("Show me")
                    }
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue)
                            .shadow(color:. yellow, radius: 1, x: 10, y: 10)
                    )
                }
                Spacer()
            }
        }
        .alert("Whoups!", isPresented: $store.showAlert) {
            Button("I get it!", role: .cancel) {}
        } message: {
            Text(store.messageError)
        }
    }
}

#Preview {
    HandleAPIErrorView()
}
