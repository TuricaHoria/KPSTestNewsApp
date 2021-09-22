//
//  ArticleView.swift
//  KPSTest
//
//  Created by Horia Turica on 22.09.2021.
//

import SwiftUI

struct ArticleView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var article: Article
    
    var body: some View {
        VStack(spacing: 8) {
            if let image = article.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.red)
                    .font(.system(size: 120))
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    if let author = article.author {
                        Text("Written by: \(author)")
                            .font(.custom("LibreFranklin-Medium", size: 16))
                    }
                    if let title = article.title {
                        Text(title)
                            .font(.custom("Merriweather-Bold", size: 24))
                    }
                    if let content = article.content {
                        Text(content)
                            .font(.custom("LibreFranklin-Regular", size: 16))
                    }
                }
                .padding()
            }
            Divider()
            HStack(spacing: 40) {
                Button {
                    
                } label: {
                    Text("Share")
                        .foregroundColor(Color("SecondaryColor"))
                }
                if let articleURL = article.url {
                    Link("Full article", destination: articleURL)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color("SecondaryColor")
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        )
                        .foregroundColor(Color.white)
                }
                
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .overlay(BackView {
            self.presentationMode.wrappedValue.dismiss()
        }, alignment: .topLeading)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article(source: ArticleSource(id: "", name: ""), author: "Horia Turica", title: "Key Democrats unhappy with Biden\'s reluctance to cancel $50,000 in student debt - CNN ", description: "", url: URL(string: ""),  publishedAt: Date(), content: ""))
    }
}
