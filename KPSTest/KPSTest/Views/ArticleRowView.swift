//
//  ArticleRowView.swift
//  KPSTest
//
//  Created by Horia Turica on 21.09.2021.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    
    private var hoursSincePublished: String? {
            guard let publishedAt = article.publishedAt else { return nil }
            return "\(Calendar.current.dateComponents([.hour], from: publishedAt, to: Date()).hour!)H"
        }
    
    var body: some View {
        HStack(spacing: 8 ) {
            VStack(alignment: .leading) {
                if let hoursSincePublished = hoursSincePublished {
                    Text(hoursSincePublished)
                        .font(.custom("LibreFranklin-Medium", size: 16))
                        .foregroundColor(.gray)
                }
                Text(article.title ?? "")
                    .font(.custom("LibreFranklin-Medium", size: 16))
            }
            Spacer()
            Group {
            if let image = article.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.red)
                    .font(.system(size: 40))
            }
            }
            .frame(width: 80, height: 80, alignment: .center)
        }
        .padding(.vertical)
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(article: Article(source: ArticleSource(id: "", name: ""), author: "", title: "Key Democrats unhappy with Biden\'s reluctance to cancel $50,000 in student debt - CNN ", description: "", url: URL(string: ""),  publishedAt: Date(), content: ""))
            .previewLayout(.sizeThatFits)
    }
}
