//  Created by Cris Messias on 31/07/25.

import SwiftUI

struct MoviesView: View {
     let store: MovieStore
    
    var body: some View {
        NavigationStack {
            if store.isLoading {
                ProgressView("Loading...")
            } else if let error = store.messageError {
                Text(error)
            } else {
                MovieListView(store: store)
            }
        }
    }
}

//#Preview {
//    MoviesView(store: MovieStore(store: MoviesClientMock()))
//}
