import SwiftUI
import UIComponents

struct ProductView: View {
    let store: ProductStore
    
    var body: some View {
        VStack(spacing: 24) {
            TitleViewComponent(title: "Products")
            List {
                if !store.products.isEmpty {
                    ForEach(store.products) { product in
                        ProductCard(name: product.name, price: product.price)
                    }
                    .listRowSeparator(.hidden)
                    .padding(10)
                } else if let error = store.errorMessage {
                    Text(error)
                } else {
                    ProgressView("Looking for products...")
                }
            }
            .listStyle(.plain)
        }
        .task {
            await store.fecthProducts()
        }
    }
}

#Preview {
    ProductView(store: ProductStore(productClient: ProductClientMock()))
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
