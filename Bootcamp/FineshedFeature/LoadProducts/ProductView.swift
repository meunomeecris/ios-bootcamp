import SwiftUI
import UIComponents

struct ProductView: View {
    let store: ProductStore
    
    var body: some View {
        VStack(spacing: 24) {
            TitleViewComponent(title: "Products")
            LoadableViewComponent(
                data: store.products,
                errorMessage: store.errorMessage,
                loadingText: "Looking for products..."
            ) {_ in
                VStack {
                    ForEach(store.products) { product in
                        ProductCard(name: product.name, price: product.price)
                    }
                    .listRowSeparator(.hidden)
                    .padding(10)
                    Spacer()
                }
            }
        }
        .task {
            await store.fecthProducts()
        }
    }
}

#Preview {
    ProductView(store: ProductStore(client: ProductClientMock()))
}


private struct ProductCard: View {
    let name: String
    let price: Double
    
    var body: some View {
        HStack {
            Text(name)
                .font(.title2)
                .bold()
            Spacer()
            Text(String(price.formatted(.currency(code: "EUR"))))
                .font(.title3)
                .kerning(2)
                .bold()
                .foregroundStyle(.green)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .circular)
                .fill(.green)
                .opacity(0.04)
        )
    }
}
