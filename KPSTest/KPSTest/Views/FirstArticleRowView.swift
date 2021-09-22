//
//  FirstArticleRowView.swift
//  KPSTest
//
//  Created by Horia Turica on 21.09.2021.
//

import SwiftUI

struct FirstArticleRowView: View {
    
    let article: Article
    @Binding var didScroll: Bool
    
    private var hoursSincePublished: String? {
        guard let publishedAt = article.publishedAt else { return nil }
        return "\(Calendar.current.dateComponents([.hour], from: publishedAt, to: Date()).hour!)H"
    }
    
    var body: some View {
        ZStack {
            GeometryReader { g -> AnyView in
                let rect = g.frame(in: .global)
                
                DispatchQueue.main.async {
                    self.didScroll = rect.minY < 25 ? true : false
                    print(rect.minY)
                }
                return AnyView(EmptyView())
            }
            frontArticleRowView
        }
    }
    
    var frontArticleRowView: some View {
        VStack(alignment: .leading) {
            if let image = article.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.red)
                    .font(.system(size: 120))
            }
            if let hoursSincePublished = hoursSincePublished {
                Text(hoursSincePublished)
                    .font(.custom("LibreFranklin-Medium", size: 16))
                    .foregroundColor(.gray)
            }
            Text(article.title ?? "")
                .font(.custom("LibreFranklin-Medium", size: 16))
        }
        .padding(.vertical)
    }
}

struct FirstArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        FirstArticleRowView(article: Article(source: ArticleSource(id: "", name: ""), author: "", title: "Key Democrats unhappy with Biden\'s reluctance to cancel $50,000 in student debt - CNN ", description: "", url: URL(string: ""),  publishedAt: Date(), content: ""), didScroll: .constant(true))
    }
}
