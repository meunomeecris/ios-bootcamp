import SwiftUI

struct ProductView: View {
    let store: ProductStore
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Products")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.green)
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
            .onAppear {
                Task {
                    await store.fecthProducts()
                }
            }
        }
    }
}


#Preview {
    ProductView(store: ProductStore(productClient: ProductClientMock()))
}


struct ProductCard: View {
    let name: String
    let price: Double
    
    var body: some View {
        HStack {
            Text(name)
                .font(.title)
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

