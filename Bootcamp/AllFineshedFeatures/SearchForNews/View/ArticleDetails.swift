//  Created by Cris Messias on 26/07/25.
//

import SwiftUI

struct ArticleDetails: View {
    let article: Article
    
    var body: some View {
        Text(article.displayDescription)
    }
}

