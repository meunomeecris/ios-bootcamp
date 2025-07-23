import SwiftUI

struct BreweryView: View {
    let store: BreweryStore
    
    var body: some View {
        ScrollView {
            Text("Breweries in France")
                .font(.largeTitle)
                .bold()
            
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
                    BreweryListView(store: store)
                }
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

private struct BreweryListView: View {
    let store: BreweryStore
    
    var body: some View {
        ForEach(store.breweries) { brewery in
            VStack(alignment: .leading, spacing: 24) {
                Label(brewery.name, systemImage: "house")
                Label(brewery.address, systemImage: "road.lanes")
                Label(brewery.stateProvince, systemImage: "map")
                Label(brewery.city, systemImage: "mappin.and.ellipse")
                Label(brewery.phone, systemImage: "phone")
                
                if let url = URL(string: brewery.website) {
                    HStack(spacing: 18) {
                        Image(systemName: "globe")
                        Link("Website", destination: url)
                    }
                }
                
                Divider()
            }
            .foregroundStyle(.indigo)
            .font(.title2)
            .padding()
        }
    }
}
