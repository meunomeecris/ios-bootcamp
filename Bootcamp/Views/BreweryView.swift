import SwiftUI

struct BreweryView: View {
    let store: BreweryStore

    var body: some View {
        Text("Breweries in France")
            .font(.largeTitle)
            VStack {
                if store.isLoding {
                    ProgressView()
                    Text("Loading Breweries...")
                        .font(.callout)
                        .bold()
                } else if let error = store.errorMessage {
                    Text(error)
                        .font(.title3)
                        .bold()
                } else {
                    List {
                        ForEach(store.breweries) { brewery in
                            VStack(alignment: .leading, spacing: 24) {
                                Text(brewery.name)
                                Text(brewery.address)
                                Text(brewery.stateProvince)
                                Text(brewery.city)
                                Text(brewery.phone)
                                if let url = URL(string: brewery.website) {
                                    Link("Website", destination: url)
                                }
                            }
                            .font(.title3)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20)
                                .fill(.yellow.opacity(0.07)))
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
        .task {
            await store.loadBreweries()
        }
    }
}

#Preview {
    BreweryView(store: BreweryStore(breweryClient: BreweryClientLive()))
}
