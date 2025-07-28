import SwiftUI

struct PhotoDetails: View {
    let title: String
    let author: String
    let date: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .bold()
                Text("Author: \(author)")
                    .font(.callout)
                Text("Author: \(date)")
                    .font(.callout)
            }
            .padding(16)
            
            Spacer()
        }
    }
}
