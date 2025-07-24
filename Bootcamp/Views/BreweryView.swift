import SwiftUI
import UIComponents

struct BreweryView: View {
    let store: BreweryStore
    
    var body: some View {
        ScrollView {
            VStack {
                TitleViewComponent(title: "Breweries in France")
                LoadableViewComponent(
                    data: store.breweries,
                    errorMessage: store.errorMessage,
                    loadingText: "Loading Paris Photos..."
                ) { _ in
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
